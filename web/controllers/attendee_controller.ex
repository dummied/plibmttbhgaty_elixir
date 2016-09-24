defmodule PlibmttbhgatyElixir.AttendeeController do
  use PlibmttbhgatyElixir.Web, :controller

  alias PlibmttbhgatyElixir.Attendee

  def index(conn, _params) do
    attendees = Repo.all(Attendee)
    render(conn, "index.json", attendees: attendees)
  end

  def create(conn, %{"attendee" => attendee_params}) do
    changeset = Attendee.changeset(%Attendee{}, attendee_params)

    case Repo.insert(changeset) do
      {:ok, attendee} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", attendee_path(conn, :show, attendee))
        |> render("show.json", attendee: attendee)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PlibmttbhgatyElixir.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    attendee = Repo.get!(Attendee, id)
    render(conn, "show.json", attendee: attendee)
  end

  def update(conn, %{"id" => id, "attendee" => attendee_params}) do
    attendee = Repo.get!(Attendee, id)
    changeset = Attendee.changeset(attendee, attendee_params)

    case Repo.update(changeset) do
      {:ok, attendee} ->
        render(conn, "show.json", attendee: attendee)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PlibmttbhgatyElixir.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    attendee = Repo.get!(Attendee, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(attendee)

    send_resp(conn, :no_content, "")
  end

  def languages(conn, _params) do
    # select unnest(ports) as port, count(*) from foo group by port
    query = from a in "attendees", select: fragment("unnest(languages) as language, count(*)"), group_by: a.languages
    languages = Repo.all(query) |> Enum.uniq
    conn
      |> put_status(:ok)
      |> json(languages)
  end

  def language(conn, %{"lang" => lang}) do
    attendees = Repo.all(
      from a in Attendee,
      where: fragment("? = ANY(?)", ^lang, a.languages)
    )
    render(conn, "index.json", attendees: attendees)
  end

end
