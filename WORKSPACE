workspace(name = "toktok")

# Protobuf
# =========================================================

# proto_library rules implicitly depend on @com_google_protobuf//:protoc,
# which is the proto-compiler.
# This statement defines the @com_google_protobuf repo.
http_archive(
    name = "com_google_protobuf",
    sha256 = "826425182ee43990731217b917c5c3ea7190cfda141af4869e6d4ad9085a740f",
    strip_prefix = "protobuf-3.5.1",
    urls = ["https://github.com/google/protobuf/archive/v3.5.1.tar.gz"],
)

# Haskell
# =========================================================

RULES_HASKELL_VERSION = "546c698cb782fd0749a3c91eb41e1f9a19c65646"

http_archive(
    name = "io_tweag_rules_haskell",
    sha256 = "3f3527dbed8295d9ae5d9acc5ba19310fbd9307fbaeba2413db641c316c774ab",
    strip_prefix = "rules_haskell-%s" % RULES_HASKELL_VERSION,
    urls = ["https://github.com/iphydf/rules_haskell/archive/%s.tar.gz" % RULES_HASKELL_VERSION],
)

load("@io_tweag_rules_haskell//haskell:repositories.bzl", "haskell_repositories")

haskell_repositories()

load("@io_tweag_rules_haskell//haskell:ghc_bindist.bzl", "ghc_bindist")
load("//third_party/haskell:haskell.bzl", "new_cabal_package")

# This repository rule creates @ghc repository.
ghc_bindist(
  name    = "ghc",
  version = "8.2.2",
)

register_toolchains("//:ghc")

new_cabal_package(
    package = "Diff-0.3.4",
    sha256 = "77b7daec5a79ade779706748f11b4d9b8f805e57a68e7406c3b5a1dee16e0c2f",
)

new_cabal_package(
    package = "HUnit-1.6.0.0",
    sha256 = "7448e6b966e98e84b7627deba23f71b508e9a61e7bc571d74304a25d30e6d0de",
)

new_cabal_package(
    package = "MissingH-1.4.0.1",
    sha256 = "283f2afd46625d98b4e29f77edadfa5e6009a227812ee2ece10091ad6a7e9b71",
)

new_cabal_package(
    package = "MonadRandom-0.5.1",
    sha256 = "9e3f0f92807285302036dc504066ae6d968c8b0b4c25d9360888f31fe1730d87",
)

new_cabal_package(
    package = "QuickCheck-2.11.3",
    sha256 = "488c5652139da0bac8b3e7d76f11320ded298549e62db530938bfee9ca981876",
)

new_cabal_package(
    package = "aeson-1.2.4.0",
    sha256 = "3401dba4fddb92c8a971f6645b38e2f8a1b286ef7061cd392a1a567640bbfc9b",
)

new_cabal_package(
    package = "aeson-compat-0.3.7.1",
    sha256 = "59740dc1e37b08e60abb47f38b87de5b9805611a1b468cd18294d5982a1dcacb",
)

new_cabal_package(
    package = "ansi-terminal-0.8.0.1",
    sha256 = "1bd4355c176c48f85f9cd3728a8dbe45ad10111b71f5e2ffc606198b3d0f4659",
)

new_cabal_package(
    package = "ansi-wl-pprint-0.6.8.2",
    sha256 = "a630721bd57678c3bfeb6c703f8249e434cbf85f40daceec4660fb8c6725cb3e",
)

new_cabal_package(
    package = "appar-0.1.4",
    sha256 = "58ea66abe4dd502d2fc01eecdb0828d5e214704a3c1b33b1f8b33974644c4b26",
)

new_cabal_package(
    package = "asn1-encoding-0.9.5",
    sha256 = "1e863bfd363f6c3760cc80f2c0d422e17845a9f79fe006030db202ecab5aaf29",
)

new_cabal_package(
    package = "asn1-parse-0.9.4",
    sha256 = "c6a328f570c69db73f8d2416f9251e8a03753f90d5d19e76cbe69509a3ceb708",
)

new_cabal_package(
    package = "asn1-types-0.3.2",
    sha256 = "0c571fff4a10559c6a630d4851ba3cdf1d558185ce3dcfca1136f9883d647217",
)

new_cabal_package(
    package = "async-2.2.1",
    sha256 = "8f0b86022a1319d3c1c68655790da4b7f98017982e27ec3f3dbfe01029d39027",
)

new_cabal_package(
    package = "attoparsec-0.13.2.2",
    sha256 = "dd93471eb969172cc4408222a3842d867adda3dd7fb39ad8a4df1b121a67d848",
)

new_cabal_package(
    package = "attoparsec-iso8601-1.0.0.0",
    sha256 = "aa6c6d87587383e386cb85e7ffcc4a6317aa8dafb8ba9a104ecac365ce2a858a",
)

new_cabal_package(
    package = "base16-bytestring-0.1.1.6",
    sha256 = "5afe65a152c5418f5f4e3579a5e0d5ca19c279dc9bf31c1a371ccbe84705c449",
)

new_cabal_package(
    package = "base64-bytestring-1.0.0.1",
    sha256 = "ab25abf4b00a2f52b270bc3ed43f1d59f16c8eec9d7dffb14df1e9265b233b50",
)

new_cabal_package(
    package = "base-compat-0.9.3",
    sha256 = "7d602b0f0543fadbd598a090c738e9ce9b07a1896673dc27f1503ae3bea1a210",
)

new_cabal_package(
    package = "basement-0.0.7",
    sha256 = "b501b9b378f35b80c60321031dbbf9ed7af46c66353f072e00f00abdd2244f70",
)

new_cabal_package(
    package = "base-orphans-0.6",
    sha256 = "c7282aa7516652e6e4a78ccdfb654a99c9da683875748ad5898a3f200be7ad0e",
)

new_cabal_package(
    package = "bifunctors-5.5.2",
    sha256 = "332bb2ea19e77dac55282daff8046d89f69514ced5b987779d887e53b5d7cb11",
)

new_cabal_package(
    package = "binary-bits-0.5",
    sha256 = "16534a018a4754d8d1eab051711c23fb741f41a0d141b289001c52824b5be794",
)

new_cabal_package(
    package = "binary-conduit-1.2.5",
    sha256 = "21d417aae0f9441ecd0e4f5aaac03bf9692fb9e85e48076c774d961567d14b1b",
)

new_cabal_package(
    package = "binary-orphans-0.1.8.0",
    sha256 = "f17557ccd98931df2bea038f25e7f835f38019ea7d53bd763f71fe64f931c0cc",
)

new_cabal_package(
    package = "blaze-builder-0.4.0.2",
    sha256 = "9ad3e4661bf5556d650fb9aa56a3ad6e6eec7575e87d472e8ab6d15eaef163d4",
)

new_cabal_package(
    package = "byteable-0.1.1",
    sha256 = "243b34a1b5b64b39e39fe58f75c18f6cad5b668b10cabcd86816cbde27783fe2",
)

new_cabal_package(
    package = "byteorder-1.0.4",
    sha256 = "bd20bbb586947f99c38a4c93d9d0266f49f6fc581767b51ba568f6d5d52d2919",
)

new_cabal_package(
    package = "bytestring-arbitrary-0.1.1",
    sha256 = "bbe78d37e9788ecf6fc4d64633047579b66e71ffcab70cbc8be100a722056efd",
)

new_cabal_package(
    package = "bytestring-conversion-0.3.1",
    sha256 = "13b7ea48737dc7a7fd4c894ff1fb9344cf8d9ef8f4201e813d578b613e874ef8",
)

new_cabal_package(
    package = "call-stack-0.1.0",
    sha256 = "f25f5e0992a39371079cc25c2a14b5abb872fa7d868a32753aac3a258b83b1e2",
)

new_cabal_package(
    package = "case-insensitive-1.2.0.10",
    sha256 = "66321c40fffb35f3a3188ba508753b74aada53fb51c822a9752614b03765306c",
)

new_cabal_package(
    package = "cereal-0.5.5.0",
    sha256 = "0b97320ffbfa6df2e5679022215dbd0fe6e3b5ae8428c2ff4310d9e1acf16822",
)

new_cabal_package(
    package = "clock-0.7.2",
    sha256 = "886601978898d3a91412fef895e864576a7125d661e1f8abc49a2a08840e691f",
)

new_cabal_package(
    package = "colour-2.3.4",
    sha256 = "0f439f00b322ce3d551f28a4dd1520aa2c91d699de4cdc6d485b9b04be0dc5eb",
)

new_cabal_package(
    package = "comonad-5.0.3",
    sha256 = "a7f4584d634051123c547f0d10f88eaf23d99229dbd01dfdcd98cddd41e54df6",
)

new_cabal_package(
    package = "conduit-1.2.13",
    sha256 = "239d1bac614bc1085315ad8d15275471fc7c0eaef05950429d40a65bd73711ac",
)

new_cabal_package(
    package = "conduit-extra-1.2.3.2",
    sha256 = "1d5b66284703a4b9fb96a4c6a2213727208639871a675da9755e9a963fa230f6",
)

new_cabal_package(
    package = "connection-0.2.8",
    sha256 = "70b1f44e8786320c18b26fc5d4ec115fc8ac016ba1f852fa8137f55d785a93eb",
)

new_cabal_package(
    package = "contravariant-1.4.1",
    sha256 = "c93d3d619fa378f3fdf92c53bb8b04b8f47963b88aba7cfa54b57656189ad0ed",
)

new_cabal_package(
    package = "cookie-0.4.3",
    sha256 = "fbfb0c4fcebe6cb85cb6b84572287a57ee7e3a380f2fe51c4885bfb460f3ed62",
)

new_cabal_package(
    package = "cryptohash-0.11.9",
    sha256 = "c28f847fc1fcd65b6eea2e74a100300af940919f04bb21d391f6a773968f22fb",
)

new_cabal_package(
    package = "cryptonite-0.25",
    sha256 = "89be1a18af8730a7bfe4d718d7d5f6ce858e9df93a411566d15bf992db5a3c8c",
)

new_cabal_package(
    package = "data-binary-ieee754-0.4.4",
    sha256 = "59975abed8f4caa602f0780c10a9b2493479e6feb71ad189bb10c3ac5678df0a",
)

new_cabal_package(
    package = "data-default-class-0.1.2.0",
    sha256 = "4f01b423f000c3e069aaf52a348564a6536797f31498bb85c3db4bd2d0973e56",
)

new_cabal_package(
    package = "data-default-instances-base-0.1.0.1",
    sha256 = "844fe453f674b6b0998da804465914abce8936c5e640d8bb8bff37ad07d7a17a",
)

new_cabal_package(
    package = "deepseq-generics-0.2.0.0",
    sha256 = "b0b3ef5546c0768ef9194519a90c629f8f2ba0348487e620bb89d512187c7c9d",
)

new_cabal_package(
    package = "distributive-0.5.3",
    sha256 = "9173805b9c941bda1f37e5aeb68ae30f57a12df9b17bd2aa86db3b7d5236a678",
)

new_cabal_package(
    package = "dlist-0.8.0.4",
    sha256 = "acf1867b80cdd618b8d904e89eea33be60d3c4c3aeb80d61f29229a301cc397a",
)

new_cabal_package(
    package = "double-conversion-2.0.2.0",
    sha256 = "44cde172395401169e844d6791b6eb0ef2c2e55a08de8dda96551cfe029ba26b",
)

new_cabal_package(
    package = "entropy-0.4",
    sha256 = "8ca7c6b5131f68d844555c11dcebfbe63e076ff99921d4096ed1a919f3651141",
)

new_cabal_package(
    package = "errors-2.2.4",
    sha256 = "ea38f78cb346661df51a53d80b3268df19df7c7cd73817aad09e8f69a06cb26c",
)

new_cabal_package(
    package = "exceptions-0.8.3",
    sha256 = "4d6ad97e8e3d5dc6ce9ae68a469dc2fd3f66e9d312bc6faa7ab162eddcef87be",
)

new_cabal_package(
    package = "foundation-0.0.20",
    sha256 = "ba6ae63a9ce0846bf942af2c3ace56600f051c61e83a0b55dd625de23a78e42d",
)

new_cabal_package(
    package = "free-5",
    sha256 = "87916bda2ae9766c1b1b35d4fe3ed3c1bcb587e61f783776af4c5b4a2adf8ae8",
)

new_cabal_package(
    package = "github-0.19",
    sha256 = "f0ea9b57cd21645bba40e37e5e7c83ad78469cc3e32526b15e9a4bb2b3b84394",
)

new_cabal_package(
    package = "hashable-1.2.6.1",
    sha256 = "94ca8789e13bc05c1582c46b709f3b0f5aeec2092be634b8606dbd9c5915bb7a",
)

new_cabal_package(
    package = "hostname-1.0",
    sha256 = "9b43dab1b6da521f35685b20555da00738c8e136eb972458c786242406a9cf5c",
)

new_cabal_package(
    package = "hourglass-0.2.11",
    sha256 = "18a6bb303fc055275cca45aaffc17b6a04b2e9d7509aa5aa5bb9d9239f4e4f51",
)

new_cabal_package(
    package = "hslogger-1.2.10",
    sha256 = "d7ca6e94a4aacb47a8dc30e3960ab8deff482d2ec9dca9a87b225e03e97e452b",
)

new_cabal_package(
    package = "hspec-2.4.8",
    sha256 = "94d4e0d688db1c62791c33b35cffc7b17f5a2d43387e1bb20d2b18f3dd6ceda2",
)

new_cabal_package(
    package = "hspec-core-2.4.8",
    sha256 = "24ca82ca29cf9379c24133f510decc5dd1dbe447c3a9bc82dbcc365c8f35f90b",
)

new_cabal_package(
    package = "hspec-expectations-0.8.2",
    sha256 = "819607ea1faf35ce5be34be61c6f50f3389ea43892d56fb28c57a9f5d54fb4ef",
)

new_cabal_package(
    package = "html-1.0.1.2",
    sha256 = "0c35495ea33d65e69c69bc7441ec8e1af69fbb43433c2aa3406c0a13a3ab3061",
)

new_cabal_package(
    package = "http-api-data-0.3.7.2",
    sha256 = "68516edab1c01d083a9f08baa9cb78adb60cb3f6e645f1096d02879a68bf6c82",
)

new_cabal_package(
    package = "http-client-0.5.10",
    sha256 = "f5f9696ed632f945f113ff23c98656aec4bcc77ed3653286c72f567d9286bac2",
)

new_cabal_package(
    package = "http-client-tls-0.3.5.3",
    sha256 = "471abf8f29a909f40b21eab26a410c0e120ae12ce337512a61dae9f52ebb4362",
)

new_cabal_package(
    package = "http-link-header-1.0.3",
    sha256 = "59bd2db4e7d14b6f7ce86848af5e38b4bd2e9963e9ffe5068c7b1a710dbdd7fe",
)

new_cabal_package(
    package = "http-types-0.12.1",
    sha256 = "3fa7715428f375b6aa4998ef17822871d7bfe1b55ebd9329efbacd4dad9969f3",
)

new_cabal_package(
    package = "integer-logarithms-1.0.2",
    sha256 = "31069ccbff489baf6c4a93cb7475640aabea9366eb0b583236f10714a682b570",
)

new_cabal_package(
    package = "iproute-1.7.1",
    sha256 = "57b8d03ca8ce92f8ec1334564f3edff53a0621ccbc43c00ba02eaa5007ee3eee",
)

new_cabal_package(
    package = "iso8601-time-0.1.4",
    sha256 = "761d737ea0841ee8fd3660cfe20041e9458be8ab424de8b3b661bb249b930126",
)

new_cabal_package(
    package = "keys-3.12",
    sha256 = "d4bfa78ff9df50224f1722925ae148279377193d04277a7dad224a47b34d5e55",
)

new_cabal_package(
    package = "language-c-0.7.1",
    sha256 = "a7447123f9b3bec9319ee2a22b22d97f03acd6566b4f6caf5b9a1f71e4f7a9ca",
)

new_cabal_package(
    package = "lifted-base-0.2.3.11",
    sha256 = "8ec47a9fce7cf5913766a5c53e1b2cf254be733fa9d62e6e2f3f24e538005aab",
)

new_cabal_package(
    package = "memory-0.14.16",
    sha256 = "7bb0834ab28ce1248f3be09df211d49d20d703cdcda3ed16cde99356e2d72b0f",
)

new_cabal_package(
    package = "mime-types-0.1.0.7",
    sha256 = "83164a24963a7ef37543349df095155b30116c208e602a159a5cd3722f66e9b9",
)

new_cabal_package(
    package = "mmorph-1.1.0",
    sha256 = "c1bcb45560753203f5ce3952f3c8a100b7d5b37c91746372c1da4988c4db74de",
)

new_cabal_package(
    package = "monad-control-1.0.2.2",
    sha256 = "1e34a21d123f2ed8bb2708e7f30343fa1d9d7f36881f9871cbcca4bb07e7e433",
)

new_cabal_package(
    package = "monad-parallel-0.7.2.3",
    sha256 = "128fb8c36be717f82aa3146d855303f48d04c56ba025078e6cd35d6050b45089",
)

new_cabal_package(
    package = "mono-traversable-1.0.8.1",
    sha256 = "991290797bd77ce2f2e23dd5dea32fb159c6cb9310615f64a0703ea4c6373935",
)

new_cabal_package(
    package = "mtl-2.2.1",
    sha256 = "cae59d79f3a16f8e9f3c9adc1010c7c6cdddc73e8a97ff4305f6439d855c8dc5",
)

new_cabal_package(
    package = "network-2.6.3.3",
    sha256 = "776668b0a969d0d57ebabf78943cfc21a1aaf7e5e2ae6288322292125c9440f5",
)

new_cabal_package(
    package = "network-info-0.2.0.9",
    sha256 = "632939efc095b8dd01a813243e8cb14f4ffd1b9052a26523b9c04dc81993aa66",
)

new_cabal_package(
    package = "network-uri-2.6.1.0",
    sha256 = "423e0a2351236f3fcfd24e39cdbc38050ec2910f82245e69ca72a661f7fc47f0",
)

new_cabal_package(
    package = "old-locale-1.0.0.7",
    sha256 = "dbaf8bf6b888fb98845705079296a23c3f40ee2f449df7312f7f7f1de18d7b50",
)

new_cabal_package(
    package = "old-time-1.1.0.3",
    sha256 = "1ccb158b0f7851715d36b757c523b026ca1541e2030d02239802ba39b4112bc1",
)

new_cabal_package(
    package = "parallel-3.2.1.1",
    sha256 = "323bb9bc9e36fb9bfb08e68a772411302b1599bfffbc6de20fa3437ce1473c17",
)

new_cabal_package(
    package = "parsec-3.1.11",
    sha256 = "6f87251cb1d11505e621274dec15972de924a9074f07f7430a18892064c2676e",
)

new_cabal_package(
    package = "pem-0.2.4",
    sha256 = "770c4c1b9cd24b3db7f511f8a48404a0d098999e28573c3743a8a296bb96f8d4",
)

new_cabal_package(
    package = "pointed-5.0.1",
    sha256 = "b94635a5c8779238501a9156015422ce2fb4d5efd45d68999e8cbe2ecc5121dd",
)

new_cabal_package(
    package = "primitive-0.6.2.0",
    sha256 = "b8e8d70213e22b3fab0e0d11525c02627489618988fdc636052ca0adce282ae1",
)

new_cabal_package(
    package = "profunctors-5.2.2",
    sha256 = "e981e6a33ac99d38a947a749179bbea3c294ecf6bfde41660fe6d8d5a2e43768",
)

new_cabal_package(
    package = "quickcheck-io-0.2.0",
    sha256 = "fb779119d79fe08ff4d502fb6869a70c9a8d5fd8ae0959f605c3c937efd96422",
)

new_cabal_package(
    package = "quickcheck-text-0.1.0.0",
    sha256 = "e7c3185870f23473be63479f5bd18aa24c84a8efff24f0f7b649c2f486c9cbf9",
)

new_cabal_package(
    package = "random-1.1",
    sha256 = "b718a41057e25a3a71df693ab0fe2263d492e759679b3c2fea6ea33b171d3a5a",
)

new_cabal_package(
    package = "regex-base-0.93.2",
    sha256 = "20dc5713a16f3d5e2e6d056b4beb9cfdc4368cd09fd56f47414c847705243278",
)

new_cabal_package(
    package = "regex-compat-0.95.1",
    sha256 = "d57cb1a5a4d66753b18eaa37a1621246f660472243b001894f970037548d953b",
)

new_cabal_package(
    package = "regex-posix-0.95.2",
    sha256 = "56019921cd4a4c9682b81ec614236fea816ba8ed8785a1640cd66d8b24fc703e",
)

new_cabal_package(
    package = "resourcet-1.1.11",
    sha256 = "346ed5c3eca87e1b2df5ca97419bd896e27ad39d997b8eea5b62f67c98a824d9",
)

new_cabal_package(
    package = "safe-0.3.16",
    sha256 = "688ae558289256aeddd8f70ca4303c36de0bb37cb70b1094a0fd4731e0235975",
)

new_cabal_package(
    package = "saltine-0.1.0.0",
    sha256 = "a2bc34fb3b9485c300e4a9eac4e6d83ef584275016be845fe5e28aec08df6dc2",
)

new_cabal_package(
    package = "scientific-0.3.5.2",
    sha256 = "5ce479ff95482fb907267516bd0f8fff450bdeea546bbd1267fe035acf975657",
)

new_cabal_package(
    package = "semigroupoids-5.2.2",
    sha256 = "e4def54834cda65ac1e74e6f12a435410e19c1348e820434a30c491c8937299e",
)

new_cabal_package(
    package = "semigroups-0.18.4",
    sha256 = "589e3042329a6bcffb5c0e85834143586db22eb7a2aae094d492cd004f685d27",
)

new_cabal_package(
    package = "setenv-0.1.1.3",
    sha256 = "e358df39afc03d5a39e2ec650652d845c85c80cc98fe331654deafb4767ecb32",
)

new_cabal_package(
    package = "socks-0.5.6",
    sha256 = "fa63cd838025e18864c59755750c0cfc4ea76e140a542f07a5c682488ec78438",
)

new_cabal_package(
    package = "split-0.2.3.3",
    sha256 = "1dcd674f7c5f276f33300f5fd59e49d1ac6fc92ae949fd06a0f6d3e9d9ac1413",
)

new_cabal_package(
    package = "stm-2.4.5.0",
    sha256 = "31d7db183f13beed5c71409d12747a7f4cf3e145630553dc86336208540859a7",
)

new_cabal_package(
    package = "streaming-commons-0.1.19",
    sha256 = "43fcae90df5548d9968b31371f13ec7271df86ac34a484c094616867ed4217a7",
)

new_cabal_package(
    package = "syb-0.7",
    sha256 = "b8757dce5ab4045c49a0ae90407d575b87ee5523a7dd5dfa5c9d54fcceff42b5",
)

new_cabal_package(
    package = "tabular-0.2.2.7",
    sha256 = "13f8da12108dafcf3194eb6bf25febf0081c7e4734f66d2d4aeee899f3c14ffb",
)

new_cabal_package(
    package = "tagged-0.8.5",
    sha256 = "e47c51c955ed77b0fa36897f652df990aa0a8c4eb278efaddcd604be00fc8d99",
)

new_cabal_package(
    package = "test-framework-0.8.2.0",
    sha256 = "f5aec7a15dbcb39e951bcf6502606fd99d751197b5510f41706899aa7e660ac2",
)

new_cabal_package(
    package = "test-framework-hunit-0.3.0.2",
    sha256 = "95cb8ee02a850b164bfdabdf4dbc839d621361f3ac770ad21ea43a8bde360bf8",
)

new_cabal_package(
    package = "text-1.2.3.0",
    sha256 = "20e0b1627f613b32cc7f2d2e8dcc48a4a61938b24f3d14fb77cee694f0c9311a",
)

new_cabal_package(
    package = "tf-random-0.5",
    sha256 = "2e30cec027b313c9e1794d326635d8fc5f79b6bf6e7580ab4b00186dadc88510",
)

new_cabal_package(
    package = "th-abstraction-0.2.6.0",
    sha256 = "e52e289a547d68f203d65f2e63ec2d87a3c613007d2fe873615c0969b981823c",
)

new_cabal_package(
    package = "th-lift-0.7.8",
    sha256 = "2cf83385e848d9136a1d6e49ca845fd1d09935f2ff658c6f4e268d8ece02c12b",
)

new_cabal_package(
    package = "th-lift-instances-0.1.11",
    sha256 = "1da46afabdc73c86f279a0557d5a8f9af1296f9f6043264ba354b1c9cc65a6b8",
)

new_cabal_package(
    package = "time-locale-compat-0.1.1.3",
    sha256 = "9144bf68b47791a2ac73f45aeadbc5910be2da9ad174909e1a10a70b4576aced",
)

new_cabal_package(
    package = "tls-1.4.1",
    sha256 = "bbead1afc0b808bd5cff7bddaeae84ade37f18bbe72bd78d45a2fa4ac41908f8",
)

new_cabal_package(
    package = "transformers-base-0.4.4",
    sha256 = "6aa3494fc70659342fbbb163035d5827ecfd8079e3c929e2372adf771fd52387",
)

new_cabal_package(
    package = "transformers-compat-0.6.0.6",
    sha256 = "fa29cffc94bba1d102176ef441d68b99696e643caf3a6fc7a554906a3162b639",
)

new_cabal_package(
    package = "typed-process-0.2.1.0",
    sha256 = "d214d88575dc0fe919d23eacd91a212ed7bf5b1dbb4360038e99926ff9bcdcd0",
)

new_cabal_package(
    package = "unexceptionalio-0.3.0",
    sha256 = "927e2be6bb9ced73c1c17d79c981cadef4039d9ee45d2d3d6b4c133ff93ff0b8",
)

new_cabal_package(
    package = "unliftio-core-0.1.1.0",
    sha256 = "7550b017d87af53ae3e0d3b8524e24a77faf739073f35e40663454a9e9752385",
)

new_cabal_package(
    package = "unordered-containers-0.2.8.0",
    sha256 = "a4a188359ff28640359131061953f7dbb8258da8ecf0542db0d23f08bfa6eea8",
)

new_cabal_package(
    package = "uri-bytestring-0.3.1.1",
    sha256 = "7f789452877d28799672c5bf9901fdcfdeaf4434d39a62849fd36cfc85e355fb",
)

new_cabal_package(
    package = "uuid-1.3.13",
    sha256 = "dfac808a7026217d018b408eab18facc6a85c6183be308d4ac7877e80599b027",
)

new_cabal_package(
    package = "uuid-types-1.0.3",
    sha256 = "9276517ab24a9b06f39d6e3c33c6c2b4ace1fc2126dbc1cd9806866a6551b3fd",
)

new_cabal_package(
    package = "vector-0.12.0.1",
    sha256 = "b100ee79b9da2651276278cd3e0f08a3c152505cc52982beda507515af173d7b",
)

new_cabal_package(
    package = "vector-algorithms-0.7.0.1",
    sha256 = "ed460a41ca068f568bc2027579ab14185fbb72c7ac469b5179ae5f8a52719070",
)

new_cabal_package(
    package = "vector-binary-instances-0.2.4",
    sha256 = "2b2f783e414dcf2e7dc34ad14264e5af83e5cd4784d5a0a64e4b4571963443f8",
)

new_cabal_package(
    package = "vector-instances-3.4",
    sha256 = "1b0246ef0cf8372d61d5c7840d857f49299af2304b5107510377255ed4dd5381",
)

new_cabal_package(
    package = "x509-1.7.3",
    sha256 = "41740f949bb773dc721d342a85587a512658c81ee8cd38f102473b315e127356",
)

new_cabal_package(
    package = "x509-store-1.6.6",
    sha256 = "6a276f595cf91c9688129cad4c9c6be9c349ffc0de22300eeb3dfa6a2b6e7635",
)

new_cabal_package(
    package = "x509-system-1.6.6",
    sha256 = "40dcdaae3ec67f38c08d96d4365b901eb8ac0c590bd7972eb429d37d58aa4419",
)

new_cabal_package(
    package = "x509-validation-1.6.10",
    sha256 = "761c9d77322528259b690508e829cb360feb1fc542951a99f3af51ae980e45d7",
)

new_cabal_package(
    package = "xml-1.3.14",
    sha256 = "32d1a1a9f21a59176d84697f96ae3a13a0198420e3e4f1c48abbab7d2425013d",
)

new_cabal_package(
    package = "zlib-0.6.1.2",
    sha256 = "e4eb4e636caf07a16a9730ce469a00b65d5748f259f43edd904dd457b198a2bb",
)

# Go
# =========================================================

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "4d8d6244320dd751590f9100cf39fd7a4b75cd901e1f3ffdfd6f048328883695",
    urls = ["https://github.com/bazelbuild/rules_go/releases/download/0.9.0/rules_go-0.9.0.tar.gz"],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "0103991d994db55b3b5d7b06336f8ae355739635e0c2379dea16b8213ea5a223",
    urls = ["https://github.com/bazelbuild/bazel-gazelle/releases/download/0.9/bazel-gazelle-0.9.tar.gz"],
)

load("@io_bazel_rules_go//go:def.bzl", "go_rules_dependencies", "go_register_toolchains")
load("@io_bazel_rules_go//go/private:go_repository.bzl", "go_repository")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

go_rules_dependencies()

go_register_toolchains()

gazelle_dependencies()

go_repository(
    name = "com_github_streamrail_concurrent_map",
    commit = "master",
    importpath = "github.com/streamrail/concurrent-map",
)

#go_repository(
#    name = "com_github_petermattis_goid",
#    commit = "master",
#    importpath = "github.com/petermattis/goid",
#)
#
# Workaround for https://github.com/bazelbuild/rules_go/issues/1262.
new_http_archive(
    name = "com_github_petermattis_goid",
    build_file = "third_party/BUILD.com_github_petermattis_goid",
    sha256 = "2c9e36159a9e3061d3b2839e33ff453d238a247483d9eac3917b567cc50b5f1c",
    strip_prefix = "goid-176e84a949d354dcef722e602b312b1a75bacddc",
    urls = ["https://github.com/petermattis/goid/archive/176e84a949d354dcef722e602b312b1a75bacddc.tar.gz"],
)

go_repository(
    name = "com_github_sasha_s_go_deadlock",
    commit = "master",
    importpath = "github.com/sasha-s/go-deadlock",
)

go_repository(
    name = "org_bitbucket_kardianos_osext",
    commit = "tip",
    importpath = "bitbucket.org/kardianos/osext",
)

# C/C++ dependencies
# =========================================================

new_local_repository(
    name = "asound",
    build_file = "third_party/BUILD.asound",
    path = "/usr",
)

new_local_repository(
    name = "openal",
    build_file = "third_party/BUILD.openal",
    path = "/usr",
)

new_local_repository(
    name = "opencv",
    build_file = "third_party/BUILD.opencv",
    path = "/usr",
)

new_http_archive(
    name = "bzip2",
    build_file = "third_party/BUILD.bzip2",
    sha256 = "a2848f34fcd5d6cf47def00461fcb528a0484d8edef8208d6d2e2909dc61d9cd",
    strip_prefix = "bzip2-1.0.6",
    urls = ["http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz"],
)

http_archive(
    name = "com_google_absl",
    sha256 = "c57ccd72d9445628178945745a112f119ae19be5cc2e3c7b99f1186f248b3d15",
    strip_prefix = "abseil-cpp-03c1513538584f4a04d666be5eb469e3979febba",
    urls = ["https://github.com/abseil/abseil-cpp/archive/03c1513538584f4a04d666be5eb469e3979febba.zip"],
)

http_archive(
    name = "com_google_googletest",
    sha256 = "da3d22cc2e096456573939ec21a1d989aca5a60fa1c89037ae05205c00202e4a",
    strip_prefix = "googletest-15392f1a38fa0b8c3f13a9732e94b209069efa1c",
    urls = ["https://github.com/google/googletest/archive/15392f1a38fa0b8c3f13a9732e94b209069efa1c.tar.gz"],
)

new_http_archive(
    name = "curl",
    build_file = "third_party/BUILD.curl",
    sha256 = "cc245bf9a1a42a45df491501d97d5593392a03f7b4f07b952793518d97666115",
    strip_prefix = "curl-7.58.0",
    urls = ["https://github.com/curl/curl/releases/download/curl-7_58_0/curl-7.58.0.tar.gz"],
)

new_http_archive(
    name = "ffmpeg",
    build_file = "third_party/BUILD.ffmpeg",
    sha256 = "f3443e20154a590ab8a9eef7bc951e8731425efc75b44ff4bee31d8a7a574a2c",
    strip_prefix = "ffmpeg-3.4.1",
    urls = ["http://ffmpeg.org/releases/ffmpeg-3.4.1.tar.bz2"],
)

new_http_archive(
    name = "filter_audio",
    build_file = "third_party/BUILD.filter_audio",
    sha256 = "fb135592c5133c3b4b664da18f988f58609db912f204059abe16277df044a366",
    strip_prefix = "filter_audio-0.0.1",
    urls = ["https://github.com/irungentoo/filter_audio/archive/v0.0.1.tar.gz"],
)

new_http_archive(
    name = "json",
    build_file = "third_party/BUILD.json",
    sha256 = "2b7234fca394d1e27b7e017117ed80b7518fafbb4f4c13a7c069624f6f924673",
    strip_prefix = "include",
    urls = ["https://github.com/nlohmann/json/releases/download/v3.1.0/include.zip"],
)

new_http_archive(
    name = "libcap",
    build_file = "third_party/BUILD.libcap",
    sha256 = "4ca80dc6f9f23d14747e4b619fd9784434c570e24a7346f326c692784ed83a86",
    strip_prefix = "libcap-2.25",
    urls = ["https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.25.tar.gz"],
)

new_http_archive(
    name = "libconfig",
    build_file = "third_party/BUILD.libconfig",
    sha256 = "f67ac44099916ae260a6c9e290a90809e7d782d96cdd462cac656ebc5b685726",
    strip_prefix = "libconfig-1.7.2",
    urls = ["https://github.com/hyperrealm/libconfig/archive/v1.7.2.tar.gz"],
)

new_http_archive(
    name = "libexif",
    build_file = "third_party/BUILD.libexif",
    sha256 = "8cb37aa1745ca9050403c501ad4da2924e98ec5460bbd5c9d09bd57f0c746636",
    strip_prefix = "libexif-libexif-0_6_21-release",
    urls = ["https://github.com/libexif/libexif/archive/libexif-0_6_21-release.tar.gz"],
)

new_http_archive(
    name = "libidn2",
    build_file = "third_party/BUILD.libidn2",
    sha256 = "644b6b03b285fb0ace02d241d59483d98bc462729d8bb3608d5cad5532f3d2f0",
    strip_prefix = "libidn2-2.0.4",
    urls = ["https://ftp.gnu.org/gnu/libidn/libidn2-2.0.4.tar.gz"],
)

new_http_archive(
    name = "libqrencode",
    build_file = "third_party/BUILD.libqrencode",
    sha256 = "c2c8a8110354463a3332cb48abf8581c8d94136af4dc1418f891cc9c7719e3c1",
    strip_prefix = "libqrencode-4.0.0",
    urls = ["https://github.com/fukuchi/libqrencode/archive/v4.0.0.tar.gz"],
)

new_http_archive(
    name = "libsodium",
    build_file = "third_party/BUILD.libsodium",
    sha256 = "eeadc7e1e1bcef09680fb4837d448fbdf57224978f865ac1c16745868fbd0533",
    strip_prefix = "libsodium-1.0.16",
    urls = ["https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz"],
)

new_http_archive(
    name = "libvpx",
    build_file = "third_party/BUILD.libvpx",
    sha256 = "1fec931eb5c94279ad219a5b6e0202358e94a93a90cfb1603578c326abfc1238",
    strip_prefix = "libvpx-1.7.0",
    urls = ["https://github.com/webmproject/libvpx/archive/v1.7.0.tar.gz"],
)

new_http_archive(
    name = "libzmq",
    build_file = "third_party/BUILD.libzmq",
    sha256 = "b428c6cdf1df4b5cdcb3a6727c6ece85c7fb05d7907c532566a115b4dda113a8",
    strip_prefix = "libzmq-4.2.3",
    urls = ["https://github.com/zeromq/libzmq/archive/v4.2.3.tar.gz"],
)

new_http_archive(
    name = "openssl",
    build_file = "third_party/BUILD.openssl",
    sha256 = "4f4bc907caff1fee6ff8593729e5729891adcee412049153a3bb4db7625e8364",
    strip_prefix = "openssl-OpenSSL_1_0_2n",
    urls = ["https://github.com/openssl/openssl/archive/OpenSSL_1_0_2n.tar.gz"],
)

new_http_archive(
    name = "opus",
    build_file = "third_party/BUILD.opus",
    sha256 = "6d258ffc874070087d15c584c0c491864baad14a55873730d9af35bf72fb1ce1",
    strip_prefix = "opus-1.2.1",
    urls = ["https://github.com/xiph/opus/archive/v1.2.1.tar.gz"],
)

new_http_archive(
    name = "portaudio",
    build_file = "third_party/BUILD.portaudio",
    sha256 = "f5a21d7dcd6ee84397446fa1fa1a0675bb2e8a4a6dceb4305a8404698d8d1513",
    strip_prefix = "portaudio",
    urls = ["http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz"],
)

new_http_archive(
    name = "sndfile",
    build_file = "third_party/BUILD.sndfile",
    sha256 = "1ff33929f042fa333aed1e8923aa628c3ee9e1eb85512686c55092d1e5a9dfa9",
    strip_prefix = "libsndfile-1.0.28",
    urls = ["http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz"],
)

new_http_archive(
    name = "libxz",
    build_file = "third_party/BUILD.libxz",
    sha256 = "71928b357d0a09a12a4b4c5fafca8c31c19b0e7d3b8ebb19622e96f26dbf28cb",
    strip_prefix = "xz-5.2.3",
    urls = ["https://netix.dl.sourceforge.net/project/lzmautils/xz-5.2.3.tar.gz"],
)

new_http_archive(
    name = "yasm",
    build_file = "third_party/BUILD.yasm",
    sha256 = "f708be0b7b8c59bc1dbe7134153cd2f31faeebaa8eec48676c10f972a1f13df3",
    strip_prefix = "yasm-1.3.0",
    urls = ["https://github.com/yasm/yasm/archive/v1.3.0.tar.gz"],
)

new_http_archive(
    name = "zlib",
    build_file = "third_party/BUILD.zlib",
    sha256 = "629380c90a77b964d896ed37163f5c3a34f6e6d897311f1df2a7016355c45eff",
    strip_prefix = "zlib-1.2.11",
    urls = ["https://github.com/madler/zlib/archive/v1.2.11.tar.gz"],
)

# Maven dependencies
# =========================================================

load("@bazel_tools//tools/build_defs/repo:maven_rules.bzl", "maven_aar")

local_repository(
    name = "org_bytedeco_javacpp_presets_ffmpeg_platform",
    path = "third_party/javacpp/ffmpeg",
)

local_repository(
    name = "org_bytedeco_javacpp_presets_opencv_platform",
    path = "third_party/javacpp/opencv",
)

maven_aar(
    name = "com_timehop_stickyheadersrecyclerview_library",
    artifact = "com.timehop.stickyheadersrecyclerview:library:0.4.3",
    sha1 = "44a237a0ebff7c7ebb10c79698f97f6d635d0e26",
)

maven_aar(
    name = "com_tonicartos_superslim",
    artifact = "com.tonicartos:superslim:0.4.13",
    sha1 = "b05a0931a2d97fd370dc4ae6e003a9f57eada69a",
)

maven_aar(
    name = "de_hdodenhof_circleimageview",
    artifact = "de.hdodenhof:circleimageview:2.1.0",
    sha1 = "c0fcd515432ccb654bc5b44af60320703880a0f6",
)

maven_aar(
    name = "com_sothree_slidinguppanel_library",
    artifact = "com.sothree.slidinguppanel:library:3.4.0",
    sha1 = "a46c103238d666c097f6fefcffb479ebb450d365",
)

maven_jar(
    name = "com_chuusai_shapeless",
    artifact = "com.chuusai:shapeless_2.11:2.3.3",
    sha1 = "ea34d4b6128b9090386945dcb952816bd9e87ce2",
)

maven_jar(
    name = "com_google_guava_guava",
    artifact = "com.google.guava:guava:19.0",
    sha1 = "6ce200f6b23222af3d8abb6b6459e6c44f4bb0e9",
)

maven_jar(
    name = "com_intellij_annotations",
    artifact = "com.intellij:annotations:12.0",
    sha1 = "bbcf6448f6d40abe506e2c83b70a3e8bfd2b4539",
)

maven_jar(
    name = "com_typesafe_scala_logging_scala_logging",
    artifact = "com.typesafe.scala-logging:scala-logging_2.11:3.7.2",
    sha1 = "5015fe84c5aec4f8eb3daa2d1663d447d65f8c02",
)

maven_jar(
    name = "junit_junit",
    artifact = "junit:junit:4.12",
    sha1 = "2973d150c0dc1fefe998f834810d68f278ea58ec",
)

maven_jar(
    name = "log4j_log4j",
    artifact = "log4j:log4j:1.2.17",
    sha1 = "5af35056b4d257e4b64b9e8069c0746e8b08629f",
)

maven_jar(
    name = "org_apache_commons_commons_lang3",
    artifact = "org.apache.commons:commons-lang3:3.4",
    sha1 = "5fe28b9518e58819180a43a850fbc0dd24b7c050",
)

maven_jar(
    name = "org_bytedeco_javacpp",
    artifact = "org.bytedeco:javacpp:1.4",
    sha1 = "6e9062d70f863a4e55b3827d42d302f94e89d7e5",
)

maven_jar(
    name = "org_bytedeco_javacpp_presets_ffmpeg",
    artifact = "org.bytedeco.javacpp-presets:ffmpeg:3.4.1-1.4",
    sha1 = "bf46f2d74014475c948f1a8e063fae50ab724520",
)

maven_jar(
    name = "org_bytedeco_javacpp_presets_opencv",
    artifact = "org.bytedeco.javacpp-presets:opencv:3.4.0-1.4",
    sha1 = "b82eeed2295f30369044b2520937d764efeb3e1e",
)

maven_jar(
    name = "org_bytedeco_javacv",
    artifact = "org.bytedeco:javacv:1.4",
    sha1 = "c443d8c648fb7e53428837e469ced47369a297af",
)

maven_jar(
    name = "org_bytedeco_javacv_platform",
    artifact = "org.bytedeco:javacv-platform:1.4",
    sha1 = "9a674bb8266e02f6c85b6f5644b7eab13119f14e",
)

maven_jar(
    name = "org_scalacheck_scalacheck",
    artifact = "org.scalacheck:scalacheck_2.11:1.13.4",
    sha1 = "7845816647d5a80d30e5a71862b31f3fee894549",
)

maven_jar(
    name = "org_scalactic_scalactic",
    artifact = "org.scalactic:scalactic_2.11:3.0.5",
    sha1 = "84f9454a7ceaa2b05a5ef36a15b9a332c5a1c697",
)

maven_jar(
    name = "org_scalatest_scalatest",
    artifact = "org.scalatest:scalatest_2.11:3.0.5",
    sha1 = "986921d9a4dafec38c0ba0a858f1e2a916cd2358",
)

maven_jar(
    name = "org_slf4j_slf4j_api",
    artifact = "org.slf4j:slf4j-api:1.7.25",
    sha1 = "da76ca59f6a57ee3102f8f9bd9cee742973efa8a",
)

maven_jar(
    name = "org_slf4j_slf4j_android",
    artifact = "org.slf4j:slf4j-android:1.7.22",
    sha1 = "74825860214ed889b38d0fc865b89af18f4e95a7",
)

maven_jar(
    name = "org_slf4j_slf4j_log4j12",
    artifact = "org.slf4j:slf4j-log4j12:1.7.22",
    sha1 = "3bb94b26c2ad2f8755302aa9bf96f03b23a76639",
)

# Scala toolchain
# =========================================================

RULES_SCALA_VERSION = "1d31d255e5f1e5d40bb27c8b3cf71f3741d69be3"

http_archive(
    name = "io_bazel_rules_scala",
    sha256 = "2402bf9a4624d8557f7fd8e457e65d677e900345759f719a24d27241767623d5",
    strip_prefix = "rules_scala-%s" % RULES_SCALA_VERSION,
    urls = ["https://github.com/bazelbuild/rules_scala/archive/%s.zip" % RULES_SCALA_VERSION],
)

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_register_toolchains()

scala_repositories()

scala_proto_repositories()

git_repository(
    name = "gmaven_rules",
    commit = "5e89b7cdc94d002c13576fad3b28b0ae30296e55",
    remote = "https://github.com/aj-michael/gmaven_rules",
)

load("@gmaven_rules//:gmaven.bzl", "gmaven_rules")

gmaven_rules()

android_sdk_repository(
    name = "androidsdk",
    api_level = 27,
    build_tools_version = "27.0.3",
    path = "third_party/android/sdk",
)

android_ndk_repository(
    name = "androidndk",
    api_level = 25,
    path = "third_party/android/android-ndk-r14b",
)

# Qt5
# =========================================================

new_local_repository(
    name = "qt",
    build_file = "third_party/BUILD.qt",
    path = "third_party/qt",
)

# Linux headers
# =========================================================

new_local_repository(
    name = "linux",
    build_file = "third_party/BUILD.linux",
    path = "/usr/include",
)

# Python
# =========================================================

load("//tools/workspace:python.bzl", "python_repository")

python_repository(
    name = "python2",
    version = "2.7",
)

python_repository(
    name = "python3",
    version = "3.5",
)

# Node.js
# =========================================================

RULES_NODE_VERSION = "56eadbd6e7545411e740d97fe1741c56dab42285"

http_archive(
    name = "org_pubref_rules_node",
    sha256 = "9ed54e5fda5154aeff7b5ed51b85b83cbb630f70178ca1a1798af671c6cf945c",
    strip_prefix = "rules_node-%s" % RULES_NODE_VERSION,
    url = "https://github.com/pubref/rules_node/archive/%s.zip" % RULES_NODE_VERSION,
)

load("@org_pubref_rules_node//node:rules.bzl", "node_repositories", "yarn_modules")

node_repositories()

yarn_modules(
    name = "yarn_modules",
    install_tools = [
        "sh",
        "dirname",
    ],
    deps = {
        "ansi-to-html": "0.6.4",
        "async": "2.6.0",
        "buffertools": "2.1.6",
        "ffi": "2.2.0",
        "firebase": "3.9.0",
        "firepad": "1.4.0",
        "grunt": "1.0.1",
        "grunt-jsdoc": "2.2.1",
        "grunt-shell": "2.1.0",
        "ink-docstrap": "1.3.2",
        "jsdoc": "3.5.5",
        "mktemp": "0.4.0",
        "mocha": "3.5.3",
        "ref": "1.3.5",
        "ref-array": "1.2.0",
        "ref-struct": "1.1.0",
        "should": "13.2.1",
        "underscore": "1.8.3",
    },
)

yarn_modules(
    name = "mocha_modules",
    deps = {"mocha": "3.5.3"},
)
