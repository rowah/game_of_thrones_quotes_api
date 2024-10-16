defmodule GotQuotesApi.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes) do
      add :sentence, :string
      add :character, :map

      timestamps(type: :utc_datetime)
    end

    create unique_index(:quotes, [:sentence])
  end
end
