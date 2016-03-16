defmodule Spectacular.SpecControllerTest do
  use Spectacular.ConnCase

  alias Spectacular.Spec
  @valid_attrs %{description: "some content", expectation: "some content", item: "some content", test: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, spec_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing specs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, spec_path(conn, :new)
    assert html_response(conn, 200) =~ "New spec"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, spec_path(conn, :create), spec: @valid_attrs
    assert redirected_to(conn) == spec_path(conn, :index)
    assert Repo.get_by(Spec, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, spec_path(conn, :create), spec: @invalid_attrs
    assert html_response(conn, 200) =~ "New spec"
  end

  test "shows chosen resource", %{conn: conn} do
    spec = Repo.insert! %Spec{}
    conn = get conn, spec_path(conn, :show, spec)
    assert html_response(conn, 200) =~ "Show spec"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, spec_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    spec = Repo.insert! %Spec{}
    conn = get conn, spec_path(conn, :edit, spec)
    assert html_response(conn, 200) =~ "Edit spec"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    spec = Repo.insert! %Spec{}
    conn = put conn, spec_path(conn, :update, spec), spec: @valid_attrs
    assert redirected_to(conn) == spec_path(conn, :show, spec)
    assert Repo.get_by(Spec, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    spec = Repo.insert! %Spec{}
    conn = put conn, spec_path(conn, :update, spec), spec: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit spec"
  end

  test "deletes chosen resource", %{conn: conn} do
    spec = Repo.insert! %Spec{}
    conn = delete conn, spec_path(conn, :delete, spec)
    assert redirected_to(conn) == spec_path(conn, :index)
    refute Repo.get(Spec, spec.id)
  end
end
