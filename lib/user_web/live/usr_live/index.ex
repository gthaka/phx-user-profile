defmodule UserWeb.UsrLive.Index do
  use UserWeb, :live_view

  alias User.Accounts
  alias User.Accounts.Usr

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :users, Accounts.list_users())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Usr")
    |> assign(:usr, Accounts.get_usr!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Usr")
    |> assign(:usr, %Usr{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:usr, nil)
  end

  @impl true
  def handle_info({UserWeb.UsrLive.FormComponent, {:saved, usr}}, socket) do
    {:noreply, stream_insert(socket, :users, usr)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    usr = Accounts.get_usr!(id)
    {:ok, _} = Accounts.delete_usr(usr)

    {:noreply, stream_delete(socket, :users, usr)}
  end
end
