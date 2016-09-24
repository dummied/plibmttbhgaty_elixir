defmodule PlibmttbhgatyElixir.Repo.Migrations.CreateAttendee do
  use Ecto.Migration

  def change do
    create table(:attendees) do
      add :name, :string
      add :bio, :text
      add :languages, {:array, :string}

      timestamps()
    end

  end
end
