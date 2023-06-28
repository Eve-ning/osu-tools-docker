# osu! Tools on Docker

Runs [osu-tools](https://github.com/ppy/osu-tools) in a Docker container.

This supports switching branches, just swap in your `GITHUB_USERNAME` and `GITHUB_BRANCH` in the `.env` file, and run
`docker compose up --build`.

## Example

### Use the `master` branch

By default, running `docker compose up --build` will use the `master` branch.

```shell
git clone https://github.com/Eve-ning/osu-tools-docker.git
cd osu-tools-docker/
docker compose up
```

It will spin up a container `osu-tools`, which you can access via docker `exec`

```shell
docker exec -it osu-tools sh
```

It will run shell, which then you can use commands in `osu-tools`

```shell
dotnet run -- difficulty 767046
```
```
ruleset: mania

╔═══════════════════════════════════════════════════════════════╤═══════════╤═════════╤════════════════╗
║beatmap                                                        │star rating│max combo│great hit window║
╟───────────────────────────────────────────────────────────────┼───────────┼─────────┼────────────────╢
║767046 - typeMARS - Triumph & Regret ([ A v a l o n ]) [Regret]│       5.48│ 3,994.00│           38.00║
╚═══════════════════════════════════════════════════════════════╧═══════════╧═════════╧════════════════╝
```

### Use forks and branches

For example, if you want to use:
1) The osu branch: https://github.com/Eve-ning/osu/tree/osu-tools-docker-testbranch
2) The osu-tools branch: https://github.com/Eve-ning/osu-tools/tree/impl-strain-json

Your `.env` should look like

```dotenv
OSU_GIT="https://github.com/ppy/osu"
OSU_TOOLS_GIT="https://github.com/ppy/osu-tools"
```

Follow the same procedure above

```shell
dotnet run -- difficulty 767046
```

As our osu branch inflates the SR, it should rise.

```
ruleset: mania

╔═══════════════════════════════════════════════════════════════╤═══════════╤═════════╤════════════════╗
║beatmap                                                        │star rating│max combo│great hit window║
╟───────────────────────────────────────────────────────────────┼───────────┼─────────┼────────────────╢
║767046 - typeMARS - Triumph & Regret ([ A v a l o n ]) [Regret]│      16.01│ 3,994.00│           38.00║
╚═══════════════════════════════════════════════════════════════╧═══════════╧═════════╧════════════════╝
```