defmodule PlibmttbhgatyElixir.AttendeeView do
  use PlibmttbhgatyElixir.Web, :view

  def render("index.json", %{attendees: attendees}) do
    %{data: render_many(attendees, PlibmttbhgatyElixir.AttendeeView, "attendee.json")}
  end

  def render("show.json", %{attendee: attendee}) do
    %{data: render_one(attendee, PlibmttbhgatyElixir.AttendeeView, "attendee.json")}
  end

  def render("attendee.json", %{attendee: attendee}) do
    %{id: attendee.id,
      name: attendee.name,
      bio: attendee.bio,
      languages: attendee.languages}
  end
end
