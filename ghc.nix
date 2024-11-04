#with ((import <nixpkgs> { }).pkgsMusl);
with (import <nixpkgs> { });

{
  ghc = haskellPackages.ghcWithPackages.override { installDocumentation = false; } (p: with p; [
    aeson
    aeson-pretty
    ansi-wl-pprint
    array
    async
    base
    base16-bytestring
    binary
    binary-conduit
    brick
    bytestring
    case-insensitive
    casing
    clock
    conduit
    conduit-extra
    containers
    cryptohash
    data-binary-ieee754
    data-default-class
    data-fix
    deepseq
    Diff
    directory
    edit-distance
    entropy
    exceptions
    expiring-cache-map
    extra
    file-embed
    filepath
    generic-arbitrary
    github
    groom
    hashable
    hspec
    html
    http-client
    http-client-tls
    http-media
    http-types
    integer-gmp
    iproute
    insert-ordered-containers
    language-c
    lens-family
    microlens
    microlens-mtl
    microlens-th
    monad-control
    monad-parallel
    MonadRandom
    monad-validate
    mtl
    network
    parallel
    pretty
    process
    QuickCheck
    quickcheck-instances
    quickcheck-text
    random
    recursion-schemes
    saltine
    scientific
    servant
    servant-server
    split
    suspend
    tabular
    text
    text-zipper
    time
    timers
    transformers
    transformers-compat
    unix
    unliftio-core
    unordered-containers
    uuid
    vector
    vty
    wai
    wai-cors
    wai-extra
    warp
    word-wrap
    yaml
  ]);
}
