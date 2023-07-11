defmodule UserWeb.UsrLive.FormComponent do
  use UserWeb, :live_component

  alias User.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage usr records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="usr-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:hashed_password]} type="text" label="Hashed password" />
        <.input field={@form[:confirmed_at]} type="datetime-local" label="Confirmed at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Usr</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{usr: usr} = assigns, socket) do
    changeset = Accounts.change_usr(usr)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"usr" => usr_params}, socket) do
    changeset =
      socket.assigns.usr
      |> Accounts.change_usr(usr_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"usr" => usr_params}, socket) do
    save_usr(socket, socket.assigns.action, usr_params)
  end

  defp save_usr(socket, :edit, usr_params) do
    case Accounts.update_usr(socket.assigns.usr, usr_params) do
      {:ok, usr} ->
        notify_parent({:saved, usr})

        {:noreply,
         socket
         |> put_flash(:info, "Usr updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_usr(socket, :new, usr_params) do
    case Accounts.create_usr(usr_params) do
      {:ok, usr} ->
        notify_parent({:saved, usr})

        {:noreply,
         socket
         |> put_flash(:info, "Usr created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
