defmodule PlibmttbhgatyElixir.Attendee do
  use PlibmttbhgatyElixir.Web, :model

  schema "attendees" do
    field :name, :string
    field :bio, :string
    field :languages, {:array, :string}

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :bio, :languages])
    |> validate_required([:name, :languages])
  end
end
