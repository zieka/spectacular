defmodule Spectacular.Spec do
  use Spectacular.Web, :model

  schema "specs" do
    field :item, :string
    field :description, :string
    field :test, :string
    field :expectation, :string

    timestamps
  end

  @required_fields ~w(item description test expectation)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
