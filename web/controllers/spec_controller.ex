defmodule Spectacular.SpecController do
  use Spectacular.Web, :controller

  alias Spectacular.Spec

  plug :scrub_params, "spec" when action in [:create, :update]

  def index(conn, _params) do
    specs = Repo.all(Spec)
    render(conn, "index.html", specs: specs)
  end

  def new(conn, _params) do
    changeset = Spec.changeset(%Spec{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"spec" => spec_params}) do
    changeset = Spec.changeset(%Spec{}, spec_params)

    case Repo.insert(changeset) do
      {:ok, _spec} ->
        conn
        |> put_flash(:info, "Spec created successfully.")
        |> redirect(to: spec_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    spec = Repo.get!(Spec, id)
    render(conn, "show.html", spec: spec)
  end

  def edit(conn, %{"id" => id}) do
    spec = Repo.get!(Spec, id)
    changeset = Spec.changeset(spec)
    render(conn, "edit.html", spec: spec, changeset: changeset)
  end

  def update(conn, %{"id" => id, "spec" => spec_params}) do
    spec = Repo.get!(Spec, id)
    changeset = Spec.changeset(spec, spec_params)

    case Repo.update(changeset) do
      {:ok, spec} ->
        conn
        |> put_flash(:info, "Spec updated successfully.")
        |> redirect(to: spec_path(conn, :show, spec))
      {:error, changeset} ->
        render(conn, "edit.html", spec: spec, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    spec = Repo.get!(Spec, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(spec)

    conn
    |> put_flash(:info, "Spec deleted successfully.")
    |> redirect(to: spec_path(conn, :index))
  end
end
