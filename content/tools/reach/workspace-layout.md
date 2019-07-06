+++
title = "Workspace Layout"
weight = 30
aliases = [
	"/tools/stellar/workspace-layout/"
]
+++

Workspace Layout
================

A "Workspace" is a core concept in using `reach`.
A workspace root is declared by the existence of `.timeless` directory,
and a workspace root is necessary context for doing any module evaluations.

The workspace has several responsibilities:

- The [catalog](/design/catalogs/) state is stored in `$WS/.timeless/catalog/*`;
- The default location for memoization records is in `$WS/.timeless/memo/*`;
- The default location for [Ware](/glossary#ware) storage is in `$WS/.timeless/warehouse`;
- Module names are determined by the relative paths within the workspace root path (and can be refined by the workspace configuration) -- more on that in the headings below;
- Alternative paths for any of these data can be specified in the workspace config file.

A Workspace must be one of the parent directories of your CWD in order for
most of the `reach` commands to work.

### Finding the Workspace root

- To find a Workspace, we iterate up dirs until finding dir named `.timeless`.
	- The dir containing this `.timeless` dir is the WorkspaceRoot.
	- The `.timeless` dir and `module.tl` _may_ be in the same dir.  There is nothing special about this.
	- **Note from earlier versions**: there is no `workspace.tl` file that marks workspaces; the `.timeless` dir is the only indicator.
- To evaluate any module, a Workspace __must__ be found.
	- **Note from earlier versions**: there is no special behavior for `module.tl` with no workspace -- it just doesn't run; an enclosing Workspace is still required.

### Module Names

Module names are determined by using the relative path of the `module.tl` file
within the workspace directory -- `$WORKSPACE/$moduleName/module.tl`.

A module may also be anonymous (effectively, if the `.timeless` dir and the
`module.tl` file are in the same directory).  In this case, everything works
the same, except it is not possible to generate candidate releases or use
this module in a recursive build (since there is no name to refer to it by).

#### Configurable workspace path <-> moduleName

Future :)

(PRs welcome.  When this feature is implemented, back-compat is simply that
the current behavior is effectively `"*": "*"` -- the path equals the module name.)

### Candidate Releases & Recursing across Modules

// TODO: "candidates" system should be defined in Design chapters

Candidate releases are stored in the `.timeless/candidates/{sagaName}/...` directory.

When evaluating a module,
so long as the moduleName can be determined (see above section about module names)
and the candidates system hasn't been explicitly disabled,
the exports from the module will automatically be stored in a release named "candidate",
in a file of the standard catalog format under the `.timeless/candidates/` dirs.

Any import which takes the shape of `"catalog:{moduleName}:candidate:{item}"` --
`"candidate"` being the key magic word -- will resolve using these candidate releases.

Note: Commands like `reach emerge --recursive` automatically generate and use
the candidates releases automatically.
