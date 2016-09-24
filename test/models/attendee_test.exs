defmodule PlibmttbhgatyElixir.AttendeeTest do
  use PlibmttbhgatyElixir.ModelCase

  alias PlibmttbhgatyElixir.Attendee

  @valid_attrs %{bio: "some content", languages: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Attendee.changeset(%Attendee{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Attendee.changeset(%Attendee{}, @invalid_attrs)
    refute changeset.valid?
  end
end
