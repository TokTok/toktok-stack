"""Generated from resolver: lts-18.18"""

core_packages = [
    "Cabal",
    "array",
    "base",
    "binary",
    "bytestring",
    "containers",
    "deepseq",
    "directory",
    "filepath",
    "ghc",
    "ghc-boot",
    "ghc-boot-th",
    "ghc-compact",
    "ghc-heap",
    "ghc-prim",
    "ghci",
    "haskeline",
    "hpc",
    "integer-gmp",
    "mtl",
    "parsec",
    "pretty",
    "process",
    "rts",
    "stm",
    "template-haskell",
    "terminfo",
    "text",
    "time",
    "transformers",
    "unix",
    "xhtml",
]
packages = (
    {
        "Diff": struct(
            sha256 = "7290ac098ad8b4748b9c10e494cc85ba54af688226ae69a465aa7b4c73f149c7",
            version = "0.4.0",
            patches = None,
        ),
        "HUnit": struct(
            sha256 = "b0b7538871ffc058486fc00740886d2f3172f8fa6869936bfe83a5e10bd744ab",
            version = "1.6.2.0",
            patches = None,
        ),
        "MonadRandom": struct(
            sha256 = "27184dadda0a49abac0208a1e6576b14217a60dc45b6839cd9e90af25ee00a9f",
            version = "0.5.3",
            patches = None,
        ),
        "OneTuple": struct(
            sha256 = "acc7721c3cb67da5d6d31b22812da1f418c2f74a84e97c30426294e4e6349a96",
            version = "0.2.2.1",
            patches = None,
        ),
        "QuickCheck": struct(
            sha256 = "d87b6c85696b601175274361fa62217894401e401e150c3c5d4013ac53cd36f3",
            version = "2.14.2",
            patches = None,
        ),
        "aeson": struct(
            sha256 = "0361c34be3d2ec945201f02501693436fbda10dcc549469481a084b2de22bfe8",
            version = "1.5.6.0",
            patches = None,
        ),
        "aeson-compat": struct(
            sha256 = "3c9cccb69618751da0349fdd80c02ca8860f14e3ed724f1ee7f0e7759bc34345",
            version = "0.3.10",
            patches = None,
        ),
        "aeson-pretty": struct(
            sha256 = "5dbc4f451dfa1e667b2c6ec5170714fed1905dc9cae6a1134b3376f355fa2a08",
            version = "0.8.9",
            patches = None,
        ),
        "alex": struct(
            sha256 = "91aa08c1d3312125fbf4284815189299bbb0be34421ab963b1f2ae06eccc5410",
            version = "3.2.6",
            patches = None,
        ),
        "ansi-terminal": struct(
            sha256 = "c6611b9e51add41db3f79eac30066c06b33a6ca2a09e586b4b361d7f98303793",
            version = "0.11",
            patches = None,
        ),
        "ansi-wl-pprint": struct(
            sha256 = "a7b2e8e7cd3f02f2954e8b17dc60a0ccd889f49e2068ebb15abfa1d42f7a4eac",
            version = "0.6.9",
            patches = None,
        ),
        "appar": struct(
            sha256 = "c4ceeddc26525b58d82c41b6d3e32141371a200a6794aae185b6266ccc81631f",
            version = "0.1.8",
            patches = None,
        ),
        "asn1-encoding": struct(
            sha256 = "d9f8deabd3b908e5cf83c0d813c08dc0143b3ec1c0d97f660d2cfa02c1c8da0a",
            version = "0.9.6",
            patches = None,
        ),
        "asn1-parse": struct(
            sha256 = "8f1fe1344d30b39dc594d74df2c55209577722af1497204b4c2b6d6e8747f39e",
            version = "0.9.5",
            patches = None,
        ),
        "asn1-types": struct(
            sha256 = "78ee92a251379298ca820fa53edbf4b33c539b9fcd887c86f520c30e3b4e21a8",
            version = "0.3.4",
            patches = None,
        ),
        "assoc": struct(
            sha256 = "d8988dc6e8718c7a3456515b769c9336aeeec730cf86fc5175247969ff8f144f",
            version = "1.0.2",
            patches = None,
        ),
        "async": struct(
            sha256 = "484df85be0e76c4fed9376451e48e1d0c6e97952ce79735b72d54297e7e0a725",
            version = "2.2.4",
            patches = None,
        ),
        "attoparsec": struct(
            sha256 = "21e0f38eaa1957bf471276afa17651c125a38924575f12c2cbd2fa534b45686f",
            version = "0.13.2.5",
            patches = None,
        ),
        "attoparsec-iso8601": struct(
            sha256 = "02952d77c78e95710eea855f4e86ca048ab9fda83c6c08dd9215f21a40604f98",
            version = "1.0.2.0",
            patches = None,
        ),
        "auto-update": struct(
            sha256 = "f4e023dc8713c387ecf20d851247597fd012cabea3872310b35e911105eb66c4",
            version = "0.1.6",
            patches = None,
        ),
        "base-compat": struct(
            sha256 = "53a6b5145442fba5a4bad6db2bcdede17f164642b48bc39b95015422a39adbdb",
            version = "0.11.2",
            patches = None,
        ),
        "base-compat-batteries": struct(
            sha256 = "31e066a5aa96af94fe6465adb959c38d63a49e01357641aa4322c754a94d3023",
            version = "0.11.2",
            patches = None,
        ),
        "base-orphans": struct(
            sha256 = "20a21c4b7adb0fd844b25e196241467406a28286b021f9b7a082ab03fa8015eb",
            version = "0.8.6",
            patches = None,
        ),
        "base-unicode-symbols": struct(
            sha256 = "4364d6c403616e9ec0c240c4cb450c66af43ea8483d73c315e96f4ba3cb97062",
            version = "0.2.4.2",
            patches = None,
        ),
        "base16-bytestring": struct(
            sha256 = "1d5a91143ef0e22157536093ec8e59d226a68220ec89378d5dcaeea86472c784",
            version = "1.0.2.0",
            patches = None,
        ),
        "base64-bytestring": struct(
            sha256 = "210d6c9042241ca52ee5d89cf221dbeb4d0e64b37391345369035ad2d9b4aca9",
            version = "1.1.0.0",
            patches = None,
        ),
        "basement": struct(
            sha256 = "53c4435b17b7df398c730406263957977fe0616b66529dafa8d1a0fd66b7fa8b",
            version = "0.0.12",
            patches = None,
        ),
        "bifunctors": struct(
            sha256 = "2b6b9672faab649995cf4c885f353b6638b6daee467a9ace40a7fc773831091c",
            version = "5.5.11",
            patches = None,
        ),
        "binary-conduit": struct(
            sha256 = "0480c3ff498bdbba6913ee8ad70d4828cf7a766bf9336a3ed8eb73676c46d29f",
            version = "1.3.1",
            patches = None,
        ),
        "binary-instances": struct(
            sha256 = "24305e5cba9b286984ad66bdff43578d93e0fc9ad903275425075356c64ce283",
            version = "1.0.2",
            patches = None,
        ),
        "binary-orphans": struct(
            sha256 = "431ad40b8d812bada186c68935c0a69aa2904ca3bc57d957e1b0fb7d73b1753d",
            version = "1.0.1",
            patches = None,
        ),
        "blaze-builder": struct(
            sha256 = "2cdc998c021d3a5f2a66a95138b93386271c26a117e7676d78264a90e536af67",
            version = "0.4.2.2",
            patches = None,
        ),
        "blaze-html": struct(
            sha256 = "60503f42546c6c1b954014d188ea137e43d74dcffd2bf6157c113fd91a0c394c",
            version = "0.9.1.2",
            patches = None,
        ),
        "blaze-markup": struct(
            sha256 = "43fc3f6872dc8d1be8d0fe091bd4775139b42179987f33d6490a7c5f1e07a349",
            version = "0.8.2.8",
            patches = None,
        ),
        "bsb-http-chunked": struct(
            sha256 = "148309e23eb8b261c1de374712372d62d8c8dc8ee504c392809c7ec33c0a0e7c",
            version = "0.0.0.4",
            patches = None,
        ),
        "byteable": struct(
            sha256 = "243b34a1b5b64b39e39fe58f75c18f6cad5b668b10cabcd86816cbde27783fe2",
            version = "0.1.1",
            patches = None,
        ),
        "byteorder": struct(
            sha256 = "bd20bbb586947f99c38a4c93d9d0266f49f6fc581767b51ba568f6d5d52d2919",
            version = "1.0.4",
            patches = None,
        ),
        "bytestring-conversion": struct(
            sha256 = "13b7ea48737dc7a7fd4c894ff1fb9344cf8d9ef8f4201e813d578b613e874ef8",
            version = "0.3.1",
            patches = None,
        ),
        "call-stack": struct(
            sha256 = "b80e8de2b87f01922b23b328655ad2f843f42495f3e1033ae907aade603c716a",
            version = "0.3.0",
            patches = None,
        ),
        "case-insensitive": struct(
            sha256 = "296dc17e0c5f3dfb3d82ced83e4c9c44c338ecde749b278b6eae512f1d04e406",
            version = "1.2.1.0",
            patches = None,
        ),
        "cereal": struct(
            sha256 = "17121355b92feea2d66220daa0ebb604a774e0d6359e2fc53bab362c44a5764f",
            version = "0.5.8.2",
            patches = None,
        ),
        "clock": struct(
            sha256 = "0b5db110c703e68b251d5883253a934b012110b45393fc65df1b095eb9a4e461",
            version = "0.8.2",
            patches = None,
        ),
        "cmdargs": struct(
            sha256 = "f7d8ea5c4e6af368d9b5d2eb994fc29235406fbe91916a6dc63bd883025eca75",
            version = "0.10.21",
            patches = None,
        ),
        "colour": struct(
            sha256 = "2cd35dcd6944a5abc9f108a5eb5ee564b6b1fa98a9ec79cefcc20b588991f871",
            version = "2.3.6",
            patches = None,
        ),
        "comonad": struct(
            sha256 = "ef6cdf2cc292cc43ee6aa96c581b235fdea8ab44a0bffb24dc79ae2b2ef33d13",
            version = "5.0.8",
            patches = None,
        ),
        "conduit": struct(
            sha256 = "2cb9832f27c7cd50daed1309f688afc4da1bd49697cbeda8ec3f81ab0bcf2197",
            version = "1.3.4.2",
            patches = None,
        ),
        "conduit-extra": struct(
            sha256 = "8a648dee203c01e647fa386bfe7a5b293ce552f8b5cab9c0dd5cb71c7cd012d9",
            version = "1.3.5",
            patches = None,
        ),
        "connection": struct(
            sha256 = "5d759589c532c34d87bfc4f6fcb732bf55b55a93559d3b94229e8347a15375d9",
            version = "0.3.1",
            patches = None,
        ),
        "contravariant": struct(
            sha256 = "062fd66580d7aad0b5ba93e644ffa7feee69276ef50f20d4ed9f1deb7642dffa",
            version = "1.5.5",
            patches = None,
        ),
        "cookie": struct(
            sha256 = "707f94d1b31018b91d6a1e9e19ef5413e20d02cab00ad93a5fd7d7b3b46a3583",
            version = "0.4.5",
            patches = None,
        ),
        "cpphs": struct(
            sha256 = "7f59b10bc3374004cee3c04fa4ee4a1b90d0dca84a3d0e436d5861a1aa3b919f",
            version = "1.20.9.1",
            patches = None,
        ),
        "cryptohash": struct(
            sha256 = "c28f847fc1fcd65b6eea2e74a100300af940919f04bb21d391f6a773968f22fb",
            version = "0.11.9",
            patches = None,
        ),
        "cryptohash-sha1": struct(
            sha256 = "a4042c97ad02eb68e766577ca35c01970c33e96cfd74ccb4dd403e3476a23241",
            version = "0.11.101.0",
            patches = None,
        ),
        "cryptonite": struct(
            sha256 = "d83a021cdaae90f3734b725a03ac7b555e999809779ec197011d2da8e1b8b08f",
            version = "0.29",
            patches = None,
        ),
        "data-binary-ieee754": struct(
            sha256 = "59975abed8f4caa602f0780c10a9b2493479e6feb71ad189bb10c3ac5678df0a",
            version = "0.4.4",
            patches = None,
        ),
        "data-default-class": struct(
            sha256 = "4f01b423f000c3e069aaf52a348564a6536797f31498bb85c3db4bd2d0973e56",
            version = "0.1.2.0",
            patches = None,
        ),
        "data-fix": struct(
            sha256 = "3a172d3bc0639c327345e965f9d9023e099425814b28dcdb7b60ff66d66219cc",
            version = "0.3.2",
            patches = None,
        ),
        "dec": struct(
            sha256 = "ecfdbd681299b2653b4d5a17f4113ac156074761372bc119dcd3e1ea9473547b",
            version = "0.0.4",
            patches = None,
        ),
        "deepseq-generics": struct(
            sha256 = "b0b3ef5546c0768ef9194519a90c629f8f2ba0348487e620bb89d512187c7c9d",
            version = "0.2.0.0",
            patches = None,
        ),
        "distributive": struct(
            sha256 = "d7351392e078f58caa46630a4b9c643e1e2e9dddee45848c5c8358e7b1316b91",
            version = "0.6.2.1",
            patches = None,
        ),
        "dlist": struct(
            sha256 = "173d637328bb173fcc365f30d29ff4a94292a1e0e5558aeb3dfc11de81510115",
            version = "1.0",
            patches = None,
        ),
        "double-conversion": struct(
            sha256 = "44cde172395401169e844d6791b6eb0ef2c2e55a08de8dda96551cfe029ba26b",
            version = "2.0.2.0",
            patches = None,
        ),
        "easy-file": struct(
            sha256 = "52f52e72ba48d60935932401c233a72bf45c582871238aecc5a18021ce67b47e",
            version = "0.2.2",
            patches = None,
        ),
        "edit-distance": struct(
            sha256 = "3e8885ee2f56ad4da940f043ae8f981ee2fe336b5e8e4ba3f7436cff4f526c4a",
            version = "0.2.2.1",
            patches = None,
        ),
        "entropy": struct(
            sha256 = "a9063dfeb566b443e6ea101fbcc22f23d8cec8b9600bfd1378b0ecadf04be9ee",
            version = "0.4.1.7",
            patches = None,
        ),
        "errors": struct(
            sha256 = "6772e5689f07e82077ffe3339bc672934d83d83a97a7d4f1349de1302cb71f75",
            version = "2.3.0",
            patches = None,
        ),
        "exceptions": struct(
            sha256 = "4d0bfb4355cffcd67d300811df9d5fe44ea3594ed63750795bfc1f797abd84cf",
            version = "0.10.4",
            patches = None,
        ),
        "expiring-cache-map": struct(
            sha256 = "0e3bc294978b46ee59bf0b4a7e7a5bd7ed5da7bc261ffebdb0cb1b60353c64b9",
            version = "0.0.6.1",
            patches = None,
        ),
        "fail": struct(
            sha256 = "6d5cdb1a5c539425a9665f740e364722e1d9d6ae37fbc55f30fe3dbbbb91d4a2",
            version = "4.9.0.0",
            patches = None,
        ),
        "fast-logger": struct(
            sha256 = "a693bfda13ea7220dc4d516134880bc0ba5652639f0d5148222f52640d5476d5",
            version = "3.0.5",
            patches = None,
        ),
        "file-embed": struct(
            sha256 = "f066b85d537a20252faa59489f6a854e4e8f39080f08730c9e195e418cec5bdd",
            version = "0.0.15.0",
            patches = None,
        ),
        "foundation": struct(
            sha256 = "ad7024365e0b5d59314bca6106d64b03903db317d5bd308c81d01a87551e31c3",
            version = "0.0.26.1",
            patches = None,
        ),
        "free": struct(
            sha256 = "b230d1e7e6bd0da6b8a1c83fe0c1609cb510bbec9fef7804b3604cd979402b88",
            version = "5.1.7",
            patches = None,
        ),
        "generic-arbitrary": struct(
            sha256 = "69f30a54e7a3d0a45288778e22e6d0d03cfc3b525dfe0a663cd4f559a619bcc6",
            version = "0.1.0",
            patches = None,
        ),
        "generic-deriving": struct(
            sha256 = "4713ed35a855af4ebdcbb62da9584188df9d97b71f296b36c63669e8185417a7",
            version = "1.14.1",
            patches = None,
        ),
        "github": struct(
            sha256 = "5591645d07c0e8c7ab21d6920f3f7bbb10c52b4331d85d264fdc590961d3986e",
            version = "0.27",
            patches = None,
        ),
        "groom": struct(
            sha256 = "a6b4a4d3af1b26f63039f04bd4176493f8dd4f6a9ab281f0e33c0151c20de59d",
            version = "0.1.2.1",
            patches = None,
        ),
        "happy": struct(
            sha256 = "3b1d3a8f93a2723b554d9f07b2cd136be1a7b2fcab1855b12b7aab5cbac8868c",
            version = "1.20.0",
            patches = None,
        ),
        "hashable": struct(
            sha256 = "822e5413fbccca6ae884d3aba4066422c8b5d58d23d18b9ecb5c03273bb19ab4",
            version = "1.3.0.0",
            patches = None,
        ),
        "haskell-src-exts": struct(
            sha256 = "67853047169fff7d3e5d87acef214ee185a6ab8c6a104ed9c59e389574cf6c05",
            version = "1.23.1",
            patches = None,
        ),
        "hourglass": struct(
            sha256 = "44335b5c402e80c60f1db6a74462be4ea29d1a9043aa994334ffee1164f1ca4a",
            version = "0.2.12",
            patches = None,
        ),
        "hspec": struct(
            sha256 = "3c1bbda1962b2a493ad0bea0039720011948ac194c4c63d1c9f44d9c6be6147c",
            version = "2.7.10",
            patches = None,
        ),
        "hspec-core": struct(
            sha256 = "61d34e914b7c6bc01cac654de7bcb587f6b17969c0e49808512ddbffcaf5698a",
            version = "2.7.10",
            patches = None,
        ),
        "hspec-expectations": struct(
            sha256 = "819607ea1faf35ce5be34be61c6f50f3389ea43892d56fb28c57a9f5d54fb4ef",
            version = "0.8.2",
            patches = None,
        ),
        "html": struct(
            sha256 = "0c35495ea33d65e69c69bc7441ec8e1af69fbb43433c2aa3406c0a13a3ab3061",
            version = "1.0.1.2",
            patches = None,
        ),
        "http-api-data": struct(
            sha256 = "d4b2cf611ed4b4c1e7f4305914e02debc9112d4ba1d66fb3a53b8e017bdfee77",
            version = "0.4.2",
            patches = None,
        ),
        "http-client": struct(
            sha256 = "5742f36965c1030d7fb52b5fc67ccd45802f6f7e55eb7595df4eef6ea0eb22f8",
            version = "0.6.4.1",
            patches = None,
        ),
        "http-client-tls": struct(
            sha256 = "471abf8f29a909f40b21eab26a410c0e120ae12ce337512a61dae9f52ebb4362",
            version = "0.3.5.3",
            patches = None,
        ),
        "http-date": struct(
            sha256 = "32f923ac1ad9bdfeadce7c52a03c9ba6225ba60dc14137cb1cdf32ea84ccf4d3",
            version = "0.0.11",
            patches = None,
        ),
        "http-link-header": struct(
            sha256 = "8a89ccb89f84d6ebd2d3f9464ffabd11777f2a7b387b3f39de97c833cb56ec96",
            version = "1.2.1",
            patches = None,
        ),
        "http-media": struct(
            sha256 = "398279d1dff5b60cd8b8c650caceca248ea1184d694bedf5df5426963b2b9c53",
            version = "0.8.0.0",
            patches = None,
        ),
        "http-types": struct(
            sha256 = "4e8a4a66477459fa436a331c75e46857ec8026283df984d54f90576cd3024016",
            version = "0.12.3",
            patches = None,
        ),
        "http2": struct(
            sha256 = "a181092a3ac68c9719200bb117f3ca03b52d2f2bb695e7ef63b6c6f6caf8828d",
            version = "3.0.2",
            patches = None,
        ),
        "indexed-traversable": struct(
            sha256 = "516858ee7198b1fed1b93c665157f9855fd947379db7f115d48c1b0d670e698d",
            version = "0.1.2",
            patches = None,
        ),
        "integer-logarithms": struct(
            sha256 = "9b0a9f9fab609b15cd015865721fb05f744a1bc77ae92fd133872de528bbea7f",
            version = "1.0.3.1",
            patches = None,
        ),
        "iproute": struct(
            sha256 = "f1751d1579fcbc1d9f86d9d1c9ede48cb71cbeb1d7b2043491c6216e4f236b63",
            version = "1.7.12",
            patches = None,
        ),
        "iso8601-time": struct(
            sha256 = "f2cd444b2be68402c773a4b451912817f06d33093aea691b42ebeed3630ff0c8",
            version = "0.1.5",
            patches = None,
        ),
        "keys": struct(
            sha256 = "d51e4288a3cc89c5be3327a499212a651549a58af78d0dfeb2cd80e19ce66646",
            version = "3.12.3",
            patches = None,
        ),
        "language-c": struct(
            sha256 = "d44cbb963fdea53ee9850af767a01137666044702938b57fda0c17644719d207",
            version = "0.9.0.1",
            patches = None,
        ),
        "lens-family": struct(
            sha256 = "6793f2a5c5030f02258532043d57eac42318cd7f9cef47f6720a7b99276f03db",
            version = "2.0.0",
            patches = None,
        ),
        "lens-family-core": struct(
            sha256 = "19b4fcd3bd37dd0056c112a9b16cf405644fabd6652013c61a5078380ed2265a",
            version = "2.0.0",
            patches = None,
        ),
        "lifted-base": struct(
            sha256 = "c134a95f56750aae806e38957bb03c59627cda16034af9e00a02b699474317c5",
            version = "0.2.3.12",
            patches = None,
        ),
        "memory": struct(
            sha256 = "e3ff892c1a94708954d0bb2c4f4ab81bc0f505352d95095319c462db1aeb3529",
            version = "0.15.0",
            patches = None,
        ),
        "mime-types": struct(
            sha256 = "0a32435169ef4ba59f4a4b8addfd0c04479410854d1b8d69a1e38fb389ba71d2",
            version = "0.1.0.9",
            patches = None,
        ),
        "mmorph": struct(
            sha256 = "46fb450e3dedab419c47b0f154badb798c9e0e8cd097f78c40a12b47e1a8092f",
            version = "1.1.5",
            patches = None,
        ),
        "monad-control": struct(
            sha256 = "ae0baea04d99375ef788140367179994a7178d400a8ce0d9026846546772713c",
            version = "1.0.3.1",
            patches = None,
        ),
        "monad-parallel": struct(
            sha256 = "3762165873745acb066022be29488298a61a59ae99576bcb0e0b7d649942567a",
            version = "0.7.2.5",
            patches = None,
        ),
        "mono-traversable": struct(
            sha256 = "98b220f3313d74227a4249210c8818e839678343e62b3ebb1b8c867cf2b974b7",
            version = "1.0.15.3",
            patches = None,
        ),
        "nats": struct(
            sha256 = "b9d2d85d8612f9b06f8c9bfd1acecd848e03ab82cfb53afe1d93f5086b6e80ec",
            version = "1.1.2",
            patches = None,
        ),
        "network": struct(
            sha256 = "d7ef590173fff2ab522fbc167f3fafb867e4ecfca279eb3ef0d137b51f142c9a",
            version = "3.1.1.1",
            patches = None,
        ),
        "network-byte-order": struct(
            sha256 = "f2b0ccc9b759d686af30aac874fc394c13c1fc8a3db00fac401c9339c263dc5e",
            version = "0.1.6",
            patches = None,
        ),
        "network-info": struct(
            sha256 = "5680f6975d34cf4f81fa7ca0c8efd682261d6a1119e06dece0f67c7bd97fd52a",
            version = "0.2.0.10",
            patches = None,
        ),
        "network-uri": struct(
            sha256 = "57856db93608a4d419f681b881c9b8d4448800d5a687587dc37e8a9e0b223584",
            version = "2.6.4.1",
            patches = None,
        ),
        "old-locale": struct(
            sha256 = "dbaf8bf6b888fb98845705079296a23c3f40ee2f449df7312f7f7f1de18d7b50",
            version = "1.0.0.7",
            patches = None,
        ),
        "old-time": struct(
            sha256 = "1ccb158b0f7851715d36b757c523b026ca1541e2030d02239802ba39b4112bc1",
            version = "1.1.0.3",
            patches = None,
        ),
        "optparse-applicative": struct(
            sha256 = "6205278362f333c52256b9dd3edf5f8fe0f84f00cb9ee000291089f6eaccd69a",
            version = "0.16.1.0",
            patches = None,
        ),
        "parallel": struct(
            sha256 = "170453a71a2a8b31cca63125533f7771d7debeb639700bdabdd779c34d8a6ef6",
            version = "3.2.2.0",
            patches = None,
        ),
        "pem": struct(
            sha256 = "770c4c1b9cd24b3db7f511f8a48404a0d098999e28573c3743a8a296bb96f8d4",
            version = "0.2.4",
            patches = None,
        ),
        "pointed": struct(
            sha256 = "0b51078a589086082f89fa86726e3c41b1e35aa55a351f26c462ad07d45a2925",
            version = "5.0.3",
            patches = None,
        ),
        "polyparse": struct(
            sha256 = "1c4c72980e1e5a4f07fea65ca08b2399581d2a6aa21eb1078f7ad286c279707b",
            version = "1.13",
            patches = None,
        ),
        "primitive": struct(
            sha256 = "3c0cfda67f1ee6f7f65108ad6f973b5bbb35ddba34b3c87746a7448f787501dc",
            version = "0.7.3.0",
            patches = None,
        ),
        "profunctors": struct(
            sha256 = "65955d7b50525a4a3bccdab1d982d2ae342897fd38140d5a94b5ef3800d8c92a",
            version = "5.6.2",
            patches = None,
        ),
        "psqueues": struct(
            sha256 = "d09750ba3578d905b54d0b3a60a7b468910a60b3165e5de98bf6f4efae3ebfb2",
            version = "0.2.7.3",
            patches = None,
        ),
        "quickcheck-io": struct(
            sha256 = "fb779119d79fe08ff4d502fb6869a70c9a8d5fd8ae0959f605c3c937efd96422",
            version = "0.2.0",
            patches = None,
        ),
        "quickcheck-text": struct(
            sha256 = "4442fdb8ae6cd469c04957d34fee46039c9dc0ddce23ce6050babe6826d0ab09",
            version = "0.1.2.1",
            patches = None,
        ),
        "random": struct(
            sha256 = "e4519cf7c058bfd5bdbe4acc782284acc9e25e74487208619ca83cbcd63fb9de",
            version = "1.2.0",
            patches = None,
        ),
        "recursion-schemes": struct(
            sha256 = "66c3492a2fb10cea81348d0828c518b96b39f354d9e37d028a3fa279933c1405",
            version = "5.2.2.2",
            patches = None,
        ),
        "resourcet": struct(
            sha256 = "054152fec5cdc044dd9310c37e548913bcec67ec4e84998a1419a8c067b43b7f",
            version = "1.2.4.3",
            patches = None,
        ),
        "safe": struct(
            sha256 = "25043442c8f8aa95955bb17467d023630632b961aaa61e807e325d9b2c33f7a2",
            version = "0.3.19",
            patches = None,
        ),
        "saltine": struct(
            sha256 = "a75b1aae629bef09c1b14364abbf8998420e0737bf2f3515ca18055ef336f9ad",
            version = "0.1.1.1",
            patches = None,
        ),
        "scientific": struct(
            sha256 = "a3a121c4b3d68fb8b9f8c709ab012e48f090ed553609247a805ad070d6b343a9",
            version = "0.3.7.0",
            patches = None,
        ),
        "semigroupoids": struct(
            sha256 = "3619241133f128aba7047dc0d1a2ae2569eba8a0bb0ff1da1abf44d413c3903e",
            version = "5.3.6",
            patches = None,
        ),
        "semigroups": struct(
            sha256 = "a520b2d90b76e4e5a7526aa07f4e793ce9f67b2ec6df397ff19aa169e2a03a40",
            version = "0.19.2",
            patches = None,
        ),
        "servant": struct(
            sha256 = "b76bf198a4dddfa9b03d5ac750e5ed3a60fa24052dedb138932ba943519d7e0c",
            version = "0.18.3",
            patches = None,
        ),
        "servant-server": struct(
            sha256 = "136acdd982769ab4450325783a2fe88ed747b1ea29789eaf2a44ab826c04cfbe",
            version = "0.18.3",
            patches = None,
        ),
        "setenv": struct(
            sha256 = "e358df39afc03d5a39e2ec650652d845c85c80cc98fe331654deafb4767ecb32",
            version = "0.1.1.3",
            patches = None,
        ),
        "simple-sendfile": struct(
            sha256 = "b6864d2b3c62ff8ea23fa24e9e26f751bfe5253c8efb1f1e4fee2ba91d065284",
            version = "0.2.30",
            patches = None,
        ),
        "singleton-bool": struct(
            sha256 = "405dd57dea92857c04f539c3394894c40c8103ea0c4f3f0fdbfbd8acccde899f",
            version = "0.1.5",
            patches = None,
        ),
        "socks": struct(
            sha256 = "734447558bb061ce768f53a0df1f2401902c6bee396cc96ce627edd986ef6a73",
            version = "0.6.1",
            patches = None,
        ),
        "sop-core": struct(
            sha256 = "dac367f1608c9bd6c5dd1697e2a30e1b760617023b96e1df7d44c6c017999db0",
            version = "0.5.0.1",
            patches = None,
        ),
        "split": struct(
            sha256 = "271fe5104c9f40034aa9a1aad6269bcecc9454bc5a57c247e69e17de996c1f2a",
            version = "0.2.3.4",
            patches = None,
        ),
        "splitmix": struct(
            sha256 = "6d065402394e7a9117093dbb4530a21342c9b1e2ec509516c8a8d0ffed98ecaa",
            version = "0.1.0.4",
            patches = None,
        ),
        "streaming-commons": struct(
            sha256 = "786bddc912a7f7cc2e23bb91877b561def99340e62c77a13cfe47dd614e63048",
            version = "0.2.2.2",
            patches = None,
        ),
        "strict": struct(
            sha256 = "dff6abc08ad637e51891bb8b475778c40926c51219eda60fd64f0d9680226241",
            version = "0.4.0.1",
            patches = None,
        ),
        "string-conversions": struct(
            sha256 = "46bcce6d9ce62c558b7658a75d9c6a62f7259d6b0473d011d8078234ad6a1994",
            version = "0.4.0.1",
            patches = None,
        ),
        "suspend": struct(
            sha256 = "2f4f5b64837e94859b75dd49b28cf77bc75d70d5ab4f9adacb46ada5da98f072",
            version = "0.2.0.0",
            patches = None,
        ),
        "syb": struct(
            sha256 = "1807c66f77e66786739387f0ae9f16d150d1cfa9d626afcb729f0e9b442a8d96",
            version = "0.7.2.1",
            patches = None,
        ),
        "tabular": struct(
            sha256 = "cb7d06eaec7945cd77db2380ed4a9b7a048c5f6abcfba766c328228be033237d",
            version = "0.2.2.8",
            patches = None,
        ),
        "tagged": struct(
            sha256 = "f5e0fcf95f0bb4aa63f428f2c01955a41ea1a42cfcf39145ed631f59a9616c02",
            version = "0.8.6.1",
            patches = None,
        ),
        "tf-random": struct(
            sha256 = "2e30cec027b313c9e1794d326635d8fc5f79b6bf6e7580ab4b00186dadc88510",
            version = "0.5",
            patches = None,
        ),
        "th-abstraction": struct(
            sha256 = "c8bb13e31d1d22a99168536a35c66e1091a6e4274b9841a023eac52c2bd3de06",
            version = "0.4.3.0",
            patches = None,
        ),
        "th-compat": struct(
            sha256 = "6b5059caf6714f47da92953badf2f556119877e09708c14e206b3ae98b8681c6",
            version = "0.1.3",
            patches = None,
        ),
        "th-lift": struct(
            sha256 = "3a5927037a10ae63e605c02228c4027c32b7bab1985ae7b5379e6363b3cd5ce4",
            version = "0.8.2",
            patches = None,
        ),
        "these": struct(
            sha256 = "d798c9f56e17def441e8f51e54cc11afdb3e76c6a9d1e9ee154e9a78da0bf508",
            version = "1.1.1.1",
            patches = None,
        ),
        "time-compat": struct(
            sha256 = "3126b267d19f31d52a3c36f13a8788be03242f829a5bddd8a3084e134d01e3a6",
            version = "1.9.5",
            patches = None,
        ),
        "time-manager": struct(
            sha256 = "90a616ed20b2119bb64f78f84230b6798cde22a35e87bc8d9ee08cdf1d90fcdb",
            version = "0.0.0",
            patches = None,
        ),
        "timers": struct(
            sha256 = "4b057105fa485eb1d9d73b3dd3de0044a00c432efc4aca64c98f14bb9aa2320c",
            version = "0.2.0.4",
            patches = None,
        ),
        "tls": struct(
            sha256 = "8a48b5ced43fac15c99158f0eedec458d77a6605c1a4302d41457f5a70ef3948",
            version = "1.5.5",
            patches = None,
        ),
        "transformers-base": struct(
            sha256 = "323bf8689eb691b122661cffa41a25e00fea7a768433fe2dde35d3da7d32cf90",
            version = "0.4.6",
            patches = None,
        ),
        "transformers-compat": struct(
            sha256 = "7e2e0251e5e6d28142615a4b950a3fabac9c0b7804b1ec4a4ae985f19519a9f9",
            version = "0.6.6",
            patches = None,
        ),
        "type-equality": struct(
            sha256 = "4728b502a211454ef682a10d7a3e817c22d06ba509df114bb267ef9d43a08ce8",
            version = "1",
            patches = None,
        ),
        "typed-process": struct(
            sha256 = "8778ce29f84e8d1ef1c001a8fb03bb37fbaa146cd8a1f6a6633365ae80563c1e",
            version = "0.2.7.0",
            patches = None,
        ),
        "unix-compat": struct(
            sha256 = "0893b597ea0db406429d0d563506af6755728eface0e1981f9392122db88e5c8",
            version = "0.5.3",
            patches = None,
        ),
        "unix-time": struct(
            sha256 = "19233f8badf921d444c6165689253d877cfed58ce08f28cad312558a9280de09",
            version = "0.4.7",
            patches = None,
        ),
        "unliftio": struct(
            sha256 = "be9e9b29e492d8430ccd6b2b70da57553a9b312875d177e769d8847ce0297555",
            version = "0.2.20",
            patches = None,
        ),
        "unliftio-core": struct(
            sha256 = "919f0d1297ea2f5373118553c1df2a9405d8b9e31a8307e829da67d4953c299a",
            version = "0.2.0.1",
            patches = None,
        ),
        "unordered-containers": struct(
            sha256 = "6c92eaf080a2dcce5481674f5e8e42fb2c66da838eec55e72a3c960bfeacd368",
            version = "0.2.15.0",
            patches = None,
        ),
        "utf8-string": struct(
            sha256 = "ee48deada7600370728c4156cb002441de770d0121ae33a68139a9ed9c19b09a",
            version = "1.0.2",
            patches = None,
        ),
        "uuid": struct(
            sha256 = "f885958d8934930b7c0f9b91f980722f7f992c9383fc98f075cf9df64c800564",
            version = "1.3.15",
            patches = None,
        ),
        "uuid-types": struct(
            sha256 = "ad68b89b7a64c07dd5c250a11be2033ee929318ff51ec7b4e4b54e1b4deba7dd",
            version = "1.0.5",
            patches = None,
        ),
        "vault": struct(
            sha256 = "ac2a6b6adf58598c5c8faa931ae961a8a2aa50ddb2f0f7a2044ff6e8c3d433a0",
            version = "0.3.1.5",
            patches = None,
        ),
        "vector": struct(
            sha256 = "fb4a53c02bd4d7fdf155c0604da9a5bb0f3b3bfce5d9960aea11c2ae235b9f35",
            version = "0.12.3.1",
            patches = None,
        ),
        "vector-algorithms": struct(
            sha256 = "76176a56778bf30a275b1089ee6db24ec6c67d92525145f8dfe215b80137af3b",
            version = "0.8.0.4",
            patches = None,
        ),
        "vector-binary-instances": struct(
            sha256 = "b72e3b2109a02c75cb8f07ef0aabba0dba6ec0148e21321a0a2b2197c9a2f54d",
            version = "0.2.5.2",
            patches = None,
        ),
        "vector-instances": struct(
            sha256 = "1b0246ef0cf8372d61d5c7840d857f49299af2304b5107510377255ed4dd5381",
            version = "3.4",
            patches = None,
        ),
        "void": struct(
            sha256 = "53af758ddc37dc63981671e503438d02c6f64a2d8744e9bec557a894431f7317",
            version = "0.7.3",
            patches = None,
        ),
        "wai": struct(
            sha256 = "5574d6541000988fe204d3032db87fd0a5404cdbde33ee4fa02e6006768229f8",
            version = "3.2.3",
            patches = None,
        ),
        "wai-app-static": struct(
            sha256 = "c8e7db8ddb31d2297df4cae0add63e514f2a8ef92a68541707585f8148690f8d",
            version = "3.1.7.2",
            patches = ["@toktok//third_party/haskell:wai-app-static.patch"],
        ),
        "wai-cors": struct(
            sha256 = "2597beb56ebd7148f9755ae2661c065a6c532e0a286717061861b149a51cfb81",
            version = "0.2.7",
            patches = None,
        ),
        "wai-extra": struct(
            sha256 = "a4797c56b18edb3b0242ce0b0524b08535d1186873964ba7a1482fcde43a6eab",
            version = "3.1.7",
            patches = None,
        ),
        "wai-logger": struct(
            sha256 = "e2fbd8c74fa0a31f9ea0faa53f4ad4e588644a34d8dfc7cc50d85c245c3c7541",
            version = "2.3.6",
            patches = None,
        ),
        "warp": struct(
            sha256 = "1c5327b51e2acd4a7c8927a5bf01dedb308bedd286ea385f7300fc2feed023d5",
            version = "3.3.18",
            patches = None,
        ),
        "word8": struct(
            sha256 = "2630934c75728bfbf390c1f0206b225507b354f68d4047b06c018a36823b5d8a",
            version = "0.1.3",
            patches = None,
        ),
        "x509": struct(
            sha256 = "b1b0fcbb4aa0d749ed2b54710c2ebd6d900cb932108ad14f97640cf4ca60c7c8",
            version = "1.7.5",
            patches = None,
        ),
        "x509-store": struct(
            sha256 = "9786356c8bfdf631ea018c3244d0854c6db2cb24e583891ea553961443f61ef9",
            version = "1.6.7",
            patches = None,
        ),
        "x509-system": struct(
            sha256 = "40dcdaae3ec67f38c08d96d4365b901eb8ac0c590bd7972eb429d37d58aa4419",
            version = "1.6.6",
            patches = None,
        ),
        "x509-validation": struct(
            sha256 = "f94321cbcc4a534adf5889ae6950f3673e38b62b89b6970b477f502ce987d19b",
            version = "1.6.11",
            patches = None,
        ),
        "zlib": struct(
            sha256 = "807f6bddf9cb3c517ce5757d991dde3c7e319953a22c86ee03d74534bd5abc88",
            version = "0.6.2.3",
            patches = None,
        ),
    }
)
