import os
from pathlib import Path
import runpy
import subprocess
import tempfile
import tomllib
import unittest

ROOT = Path(__file__).resolve().parent.parent
MERGE = runpy.run_path(str(ROOT / 'bin/codex-setup'))['merge']


class CodexSetupTest(unittest.TestCase):
    def test_preserves_private_values_and_is_idempotent(self):
        source = '''# private settings
model = "old"
[mcp_servers.private.env]
TOKEN = "test-only-secret"
[projects."/private/work"]
trust_level = "trusted"
[tui]
vim_mode_default = false
custom_setting = "preserve"
'''
        template = 'model = "new"\n[tui]\nvim_mode_default = true\n'
        result = MERGE(source, template)
        self.assertIn('# private settings', result)
        expected = tomllib.loads(source)
        expected['model'] = 'new'
        expected['tui']['vim_mode_default'] = True
        self.assertEqual(tomllib.loads(result), expected)
        self.assertEqual(MERGE(result, template), result)

    def test_rejects_ambiguous_multiline_replacement(self):
        with self.assertRaises(ValueError):
            MERGE('model = """old\nvalue"""\n', 'model = "new"\n')

    def test_check_backup_permissions_and_symlink_rejection(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / 'config.toml'
            original = b'[projects."/private"]\ntrust_level = "trusted"\n'
            target.write_bytes(original)
            command = ['python3', str(ROOT / 'bin/codex-setup'), '--config', str(target)]
            subprocess.run(command + ['--check'], check=True, capture_output=True)
            self.assertEqual(target.read_bytes(), original)
            self.assertEqual(len(list(Path(directory).iterdir())), 1)
            subprocess.run(command, check=True, capture_output=True)
            backup, = Path(directory).glob('config.toml.backup-*')
            self.assertEqual(backup.read_bytes(), original)
            self.assertEqual(target.stat().st_mode & 0o777, 0o600)
            self.assertEqual(backup.stat().st_mode & 0o777, 0o600)
            subprocess.run(command, check=True, capture_output=True)
            self.assertEqual(len(list(Path(directory).glob('config.toml.backup-*'))), 1)
            target.unlink()
            target.symlink_to(backup)
            result = subprocess.run(command, capture_output=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertEqual(backup.read_bytes(), original)

    def test_empty_config(self):
        template = (ROOT / 'codex/config.toml').read_text()
        self.assertEqual(tomllib.loads(MERGE('', template)), tomllib.loads(template))


if __name__ == '__main__':
    unittest.main()
