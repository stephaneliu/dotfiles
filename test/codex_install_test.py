"""Exercise the installer's Codex gate without installing software."""
from pathlib import Path
import subprocess
import unittest

ROOT = Path(__file__).resolve().parent.parent
SOURCE = (ROOT / 'install').read_text()
BLOCK = SOURCE[SOURCE.index('  # Homebrew bundle installs Codex'):SOURCE.index('  echo "+++ Setting up Claude Code"')]
BLOCK = BLOCK.replace('"$HOME/.dotfiles/bin/codex-setup"', 'echo preferences-applied')


class CodexInstallTest(unittest.TestCase):
    def run_gate(self, failures=0, input_text='', marketplace_status=0):
        stub = '''set -e
attempt=0
codex() {
  if [ "$1" = --version ]; then
    attempt=$((attempt + 1))
    [ "$attempt" -gt FAILURES ]
  else
    echo "codex $*"
    if [ "$2" = marketplace ]; then return MARKETPLACE_STATUS; fi
  fi
}
'''.replace('FAILURES', str(failures)).replace('MARKETPLACE_STATUS', str(marketplace_status))
        return subprocess.run(['/bin/sh', '-c', stub + BLOCK], input=input_text,
                              text=True, capture_output=True, timeout=5)

    def test_installed_continues_without_prompt(self):
        result = self.run_gate()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertNotIn('Press [Enter]', result.stdout)
        self.assertIn('preferences-applied', result.stdout)
        self.assertIn('codex plugin marketplace add joenandez/spectre', result.stdout)
        self.assertIn('codex plugin add spectre@spectre', result.stdout)

    def test_unavailable_stops_before_setup(self):
        result = self.run_gate(failures=1)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('unavailable after brew bundle', result.stderr)
        self.assertNotIn('Press [Enter]', result.stdout)
        self.assertNotIn('preferences-applied', result.stdout)
        self.assertNotIn('codex plugin', result.stdout)

    def test_marketplace_failure_stops_plugin_install(self):
        result = self.run_gate(marketplace_status=1)
        self.assertNotEqual(result.returncode, 0)
        self.assertNotIn('codex plugin add spectre@spectre', result.stdout)


if __name__ == '__main__':
    unittest.main()
