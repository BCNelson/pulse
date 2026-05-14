# Pulse DevTools

Pulse-specific Flutter DevTools extension.

The extension appears as one top-level `Pulse` tab in Flutter DevTools and then
uses internal tabs for Outbox, Cache, Auth, GraphQL, Realtime, and Composer
state.

Build and validate the extension assets from the repo dev shell:

```sh
mobile-devtools-build
mobile-devtools-validate
```

Equivalent commands from this directory:

```sh
dart run devtools_extensions build_and_copy --source=. --dest=extension/devtools
dart run devtools_extensions validate --package=.
```

The app registers its VM service hooks from an `assert`, so the live snapshot
endpoint is only present in debug mode.

Generated assets under `extension/devtools/build` are local build output and are
not committed.
