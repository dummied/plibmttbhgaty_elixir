defmodule PlibmttbhgatyElixir.AttendeeControllerTest do
  use PlibmttbhgatyElixir.ConnCase

  alias PlibmttbhgatyElixir.Attendee
  @valid_attrs %{bio: "some content", languages: "some content", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, attendee_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    attendee = Repo.insert! %Attendee{}
    conn = get conn, attendee_path(conn, :show, attendee)
    assert json_response(conn, 200)["data"] == %{"id" => attendee.id,
      "name" => attendee.name,
      "bio" => attendee.bio,
      "languages" => attendee.languages}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, attendee_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, attendee_path(conn, :create), attendee: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Attendee, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, attendee_path(conn, :create), attendee: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    attendee = Repo.insert! %Attendee{}
    conn = put conn, attendee_path(conn, :update, attendee), attendee: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Attendee, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    attendee = Repo.insert! %Attendee{}
    conn = put conn, attendee_path(conn, :update, attendee), attendee: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    attendee = Repo.insert! %Attendee{}
    conn = delete conn, attendee_path(conn, :delete, attendee)
    assert response(conn, 204)
    refute Repo.get(Attendee, attendee.id)
  end
end
