# sveltekit-template

Opinionated starting point for new SvelteKit projects. Clone, rename, build.

## What's Included

### Tooling

- **[Bun](https://bun.sh/)** - runtime, package manager, and script runner
- **[SvelteKit](https://svelte.dev/docs/kit/introduction)** - application framework
- **[Svelte 5](https://svelte.dev/docs/svelte/overview)** - component framework
- **[Vite](https://vite.dev/)** - dev server and production bundler
- **[Tailwind CSS](https://tailwindcss.com/)** - utility-first styling
- **[Ultracite](https://www.ultracite.ai/)** - Biome-based linting and formatting preset
- **[svelte-adapter-bun](https://github.com/gornostay25/svelte-adapter-bun)** - Bun server adapter

### UI

- Tailwind CSS 4 wired through the Vite plugin
- `@/*` alias mapped to `src/lib/*`
- `clsx`, `tailwind-merge`, and `tailwind-variants` for component class composition
- Starter shadcn-style button component in `src/lib/components/ui/button`
- `@lucide/svelte` for icons
- `mode-watcher` for theme mode handling
- `runed` and `zod` for Svelte utilities and validation

### Editor (VS Code)

`.vscode/settings.json` configures format-on-save with Biome/Ultracite for Svelte, TypeScript, JavaScript, CSS, JSON, Markdown, YAML, and related files.

It also configures explicit save actions for:

- Biome fixes
- Biome import organization

### AI agents

Pre-wired for **Claude Code** (`.claude/`) and **OpenAI Codex CLI** (`.codex/`).

Claude and Codex hooks run `bun fix --skip=correctness/noUnusedImports` after file edits so generated code follows the same Ultracite formatting and linting rules.

Skills live in both `.agents/` and `.claude/` (Claude Code doesn't inherit from `.agents/`), preloaded with:

- **[Matt Pocock's skills](https://github.com/mattpocock/skills)** - TDD, diagnose, grill-me, triage, and more. After cloning and renaming the repo, run the `setup-matt-pocock-skills` skill if you plan to use them.
- **[btca-local](https://github.com/davis7dotsh/better-context/blob/main/skills/btca-local/SKILL.md)** - "Better Context App Local".

Triggered with `use btca`, it lets the agent search any git repo locally by cloning (or updating) it under `~/.btca/agent/sandbox` and answering questions against the source with citations and code snippets.

## Usage

After cloning, rename the project (replaces `sveltekit-template` everywhere, runs `bun install`, deletes itself):

```bash
./rename.sh my-new-project
```

```bash
bun install      # install deps
bun run dev      # start dev server
bun run build    # production build
bun run preview  # preview production build
bun run check    # lint and format check
bun run fix      # auto-fix lint and format issues
```

Application routes live under `src/routes`; shared code lives under `src/lib`.

## Configuration

Lint/format rules live in `biome.jsonc` and extend Ultracite's core, Svelte, and Vitest presets.

Runtime and build configuration:

- `svelte.config.js` uses `svelte-adapter-bun`
- `vite.config.ts` enables SvelteKit and Tailwind CSS
- `tsconfig.json` extends the generated SvelteKit TypeScript config
