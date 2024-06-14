n_map("\\", ":Ag! -Q --smart-case --ignore-dir app/frontend --ignore-dir spec/cassettes<Space>")

-- n_map("{", ':Ag! -Q  \b<C-R>=expand("<cword>")\b')
-- Should be above but need extra ) because it doesn't escape correctly
-- Press enter twice
n_map("{", ':Ag! -Q  \b<C-R>=expand("<cword>"))\b')
