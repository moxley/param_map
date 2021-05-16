defmodule ParamMapTest do
  use ExUnit.Case
  doctest ParamMap

  describe "take/2" do
    test "intersecting key" do
      map = ParamMap.take(%{"a" => "a", "b" => "b"}, [:a])
      assert map == %{a: "a"}
    end

    test "no match" do
      map = ParamMap.take(%{"a" => "a"}, [:b])
      assert map == %{}
    end
  end
end
