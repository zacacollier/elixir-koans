defmodule WatcherTest do
  use ExUnit.Case

  test "watches for changes" do
    parent = self()

    tell_me_about_files = fn (file) -> send parent, {:file, file} end

    {:ok, path} = Briefly.create(directory: true)

    spawn_link fn ->  Watcher.start_link(%{
      folder_to_watch: path,
      handler: tell_me_about_files,
      name: :test_watcher
    }) end

    test_file = Path.join(path, "test.exs")
    write_and_modify(test_file)

    assert_receive {:file, test_file}, 1_000
  end

  def write_and_modify(file) do
    :ok = File.write!(file, "Some Text")

    :timer.sleep(500)

    :ok = File.write!(file, "Some Other Text")
  end
end
