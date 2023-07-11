defmodule UserWeb.UsrLive.Show do
  use UserWeb, :live_view

  alias User.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:usr, Accounts.get_usr!(id))}
  end

  defp page_title(:show), do: "Show Usr"
  defp page_title(:edit), do: "Edit Usr"
end
