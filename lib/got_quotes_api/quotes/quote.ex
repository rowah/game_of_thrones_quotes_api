defmodule GotQuotesApi.Quotes.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotes" do
    field :character, :map
    field :sentence, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [:sentence, :character])
    |> validate_required([:sentence, :character])
    |> unique_constraint(:sentence)
  end
end
