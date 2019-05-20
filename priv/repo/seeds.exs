# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, _user} =
  Blog.Accounts.create_user(%{
    username: "andre",
    password: "narutomelhorquegot",
    permissions: %{default: [:read_users, :write_users, :admin]}
  })
