defmodule Spectacular.SpecTest do
  use Spectacular.ModelCase

  alias Spectacular.Spec

  @valid_attrs %{description: "some content", expectation: "some content", item: "some content", test: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Spec.changeset(%Spec{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Spec.changeset(%Spec{}, @invalid_attrs)
    refute changeset.valid?
  end
end
