defmodule Hangman.Impl.Game do

  alias Hangman.Type
  @type t :: %Hangman.Impl.Game{
    turns_left: integer,
    game_state: Type.state,
    letters: list(String.t),
    used: MapSet.t(String.t),
  }
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )


  @spec new_game() :: t
  def new_game, do: new_game(Dictionary.random_word)

  @spec new_game(String.t) :: t
  def new_game(word) do
    %__MODULE__{
      letters: word |> String.codepoints
    }
  end

  @spec make_move(t, String.t) :: { t, Type.Tally}
  def make_move(game = %{ game_state: state}, _guess) when state in [:won, :lost], do: { game, tally(game)}

  @spec tally(t) :: Type.Tally
  defp tally(game) do
    %{
      turns_left: game.turns_left,
      game_state: game.game_state,
      letters: [],
      used: game.used |> MapSet.to_list |> Enum.sort,
    }
  end
end
