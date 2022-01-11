import org.scalacheck.Gen
import org.scalatest.WordSpec
import org.scalatestplus.scalacheck.ScalaCheckPropertyChecks
import test.proto.SomeType

/**
 * This test really just exists to exercise scala_test in third_party before
 * we're able to load the full source tree. It forces Bazel to instantiate the
 * Scala rules and download its dependencies.
 */
final class EmptyTest extends WordSpec with ScalaCheckPropertyChecks {

  "generated value" should {
    "be between 0 and 10 (inclusive)" in {
      forAll(Gen.choose(0, 10)) { value =>
        assert(value <= 10)
        assert(value >= 0)
      }
    }
  }

  "proto object" should {
    "be constructible" in {
      new SomeType
    }
  }

}
