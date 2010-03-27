require 'test_helper'

class Hash4hashTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  context "NilClass" do
    should "return only one value" do
      assert_equal "nil", nil.value4hash
    end
  end

  context "String" do
    should "return itself" do
      assert_equal "asdf", "asdf".value4hash
    end
  end

  context "Symbol" do
    should "return string if option is set" do
      Hash4Hash::OPTIONS[:symbol_as_string] = true
      assert_equal "asdf".value4hash, :asdf.value4hash
    end

    should "raise error if option is not set" do
      Hash4Hash::OPTIONS[:symbol_as_string] = false
      assert_raise RuntimeError do
        :asdf.value4hash
      end
    end
  end

  context "Array" do
    should "have same hash for different orders if option is set to true" do
      Hash4Hash::OPTIONS[:array_order_matters] = false
      assert_equal %w(a b c).value4hash, %w(a c b).value4hash
    end

    should "have same hash for different orders if option is set to false" do
      Hash4Hash::OPTIONS[:array_order_matters] = true
      assert_not_equal %w(a b c).value4hash, %w(a c b).value4hash
    end
  end

  context "Hash" do
    should "have same hash for different orders if option is set to false" do
      Hash4Hash::OPTIONS[:symbol_as_string] = true
      Hash4Hash::OPTIONS[:array_order_matters] = false
      assert_equal({:a => :b, :c => :d}.value4hash, {:c => :d, :a => :b}.value4hash)
    end
  end
end
