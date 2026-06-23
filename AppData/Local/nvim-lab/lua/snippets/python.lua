local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("python", {
	s("aio", {
		t({
			"from aiohttp import ClientSession",
			"from rich.console import Console",
			"import asyncio",
			"",
			"console: Console = Console()",
			"",
			"",
			"async def main():",
			"    ",
		}),
		i(1),

		t({
			"",
			"",
			'if __name__ == "__main__":',
			"    asyncio.run(main())",
		}),
	}),
})
