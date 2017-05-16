use ExGuard.Config

guard("unit-test", run_on_start: false)
|> command("mix test --color")
|> watch({~r{lib/(?<file>.+).ex$}, fn(m) -> "test/#{m["file"]}_test.exs" end})
|> watch({~r{lib/(?<dir>.+)/(?<file>.+).ex$}, fn(m) -> "test/#{m["dir"]}/#{m["file"]}_test.exs" end})
|> watch({~r{test/(?<file>.+)_test.exs$}, fn(m) -> "test/#{m["file"]}_test.exs" end})
|> watch({~r{test/(?<dir>.+)/(?<file>.+)_test.exs$}, fn(m) -> "test/#{m["dir"]}/#{m["file"]}_test.exs" end})
|> notification(:auto)


guard("docs")
|> command("mix docs")
|> watch(~r{\.(erl|ex|exs|eex|xrl|yrl)\z}i)
|> ignore(~r/priv/)