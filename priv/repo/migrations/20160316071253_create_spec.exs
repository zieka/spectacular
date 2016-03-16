defmodule Spectacular.Repo.Migrations.CreateSpec do
  use Ecto.Migration

  def change do
    create table(:specs) do
      add :item, :string
      add :description, :string
      add :test, :string
      add :expectation, :string

      timestamps
    end

  end
end
