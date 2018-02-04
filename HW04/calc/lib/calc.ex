defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """
  @doc """
  Calculator

  ## Examples

      iex> Calc.eval("2 + 3")
      5
      iex> Calc.eval("5 * 1")
      5
      iex> Calc.eval("3 + 10")
      13
      iex> Calc.eval("2 / 3")
      0
      iex> Calc.eval("2 + 3 - 1")
      4
      iex> Calc.eval("2 / 3 + 10")
      10

  """
  def main() do
    case IO.gets("Expression: ") do
      :eof ->
        IO.puts "All done"
      {:error, reason} ->
        IO.puts "Error: #{reason}"
      line ->
        IO.puts(eval(line))
        main()
    end
  end

  def eval(expression) do
    try do
      expression
      |> patternMatch(expression)
    rescue
      RuntimeError -> "Error!"
      ArithmeticError -> "Please Provide a Valid Expression!"
    end
  end

  def patternMatch(expression, new_expression) do
    cond do
      paranthesisFinder(new_expression) ->
        idx = Regex.run(~r/\((.+)\)/, new_expression, return: :index)
        {start, len} = Enum.at(idx, 0)
        newExp = String.slice(new_expression, start + 1, len - 2)
        patternMatch(expression, newExp)

      Regex.match?(~r/\(([^)]+)\)/, new_expression) ->
        idx = Regex.run(~r/\(([^)]+)\)/, new_expression, return: :index)
        {start, len} = Enum.at(idx, 0)
        newExp = String.slice(new_expression, start + 1, len - 2)
        patternMatch(expression, newExp)

      String.contains?(expression, ["(", ")"]) ->
        new_value = new_expression |> tokenize()
        new_exp = String.replace(expression, "(" <> new_expression <> ")", Integer.to_string(new_value))
        patternMatch(new_exp, new_exp)

      true ->
        expression |> tokenize()
    end
  end

  def paranthesisFinder(expression) do
    expList = Enum.filter(String.split(expression,""),fn(x) -> x in ["(",")"] end)
    cond do
      length(expList) == 0 -> false
      Enum.at(expList,0)== "(" and Enum.at(expList,1)== "(" -> true
      true -> false
    end
  end

  def tokenize(input) do
    String.split(input)
    |> Enum.filter(fn x -> x not in ["", " ", "\n"] end)
    |> Enum.map(&getNums/1)
    |> populateStacks()
  end

  def getNums(exp) do
    cond do
      exp in ["+", "-", "/", "*", "(", ")", "", " ", "\n"] ->
        exp
      true ->
        String.to_integer(exp)
    end
  end

  def getPrecedence(op1, op2) do
    if (op1 == "*" || op1 == "/") && (op2 == "+" || op2 == "-") do
      false
    else
      true
    end
  end

  def populateStacks(exp) do
    operatorstack = Enum.filter(exp, fn x -> x in ["+", "-", "/", "*", "(", ")"] end)
    operandstack = Enum.filter(exp, fn x -> is_integer(x) end)
    value = calculate(operatorstack, operandstack)
    value
  end

  def calculate(operator, operand) do
    cond do
      length(operator) == 1 -> get_op(operator, Enum.at(operand, 0), Enum.at(operand, 1))
      true -> updateStack(operator, operand, 1, 1)
    end
  end

  def updateStack(operator, operand, operator_pos, operand_pos) do
    cond do
      length(operator) == 0 ->
        operand

      operator_pos == length(operator) ->
        exhaustList(operator, operand, 0, 0)

      getPrecedence(Enum.at(operator, operator_pos), Enum.at(operator, operator_pos - 1)) ->
        newval = get_op(Enum.at(operator, operator_pos - 1), Enum.at(operand, operand_pos - 1), Enum.at(operand, operand_pos))
        newoperand =
          List.replace_at(operand, operand_pos - 1, newval)
          |> List.delete_at(operand_pos)
        newoperator = List.delete_at(operator, operator_pos - 1)
        updateStack(newoperator, newoperand, operator_pos, operand_pos)

      Enum.at(operator, operator_pos) == "*" ->
        newval = get_op(Enum.at(operator, operator_pos), Enum.at(operand, operand_pos), Enum.at(operand, operand_pos + 1))
        newoperand =
          List.replace_at(operand, operand_pos, newval)
          |> List.delete_at(operand_pos + 1)
        newoperator = List.delete_at(operator, operator_pos)
        updateStack(newoperator, newoperand, operator_pos, operand_pos)

      Enum.at(operator, operator_pos) == "/" ->
        newval = get_op(Enum.at(operator, operator_pos), Enum.at(operand, operand_pos), Enum.at(operand, operand_pos + 1))
        newoperand =
          List.replace_at(operand, operand_pos, newval)
          |> List.delete_at(operand_pos + 1)
        newoperator = List.delete_at(operator, operator_pos)
        updateStack(newoperator, newoperand, operator_pos, operand_pos)

      true ->
        updateStack(operator, operand, operator_pos + 1, operand_pos + 1)
    end
  end


  def exhaustList(operator, operand, operator_pos, operand_pos) do
    cond do
      length(operator) == 1 ->
        get_op(operator, Enum.at(operand, 0), Enum.at(operand, 1))

      length(operator) > 1 ->
        newval = get_op(Enum.at(operator, operator_pos), Enum.at(operand, operand_pos), Enum.at(operand, operand_pos + 1))

        newoperand =
          List.replace_at(operand, operand_pos, newval)
          |> List.delete_at(operand_pos + 1)

        newoperator = List.delete_at(operator, operator_pos)
        exhaustList(newoperator, newoperand, operator_pos, operand_pos)

      true ->
        operand
    end
  end

  def get_op(op, op1, op2) do
    cond do
      "#{op}" == "+" -> add(op1 , op2)
      "#{op}" == "-" -> sub(op1 , op2 )
      "#{op}" == "/" -> division(op1 , op2 )
      "#{op}" == "*" -> mul(op1 , op2 )
    end
  end

  def add(number1 , number2) do
    number1 + number2
  end

  def mul(number1 , number2 ) do
    number1 * number2
  end

  def division(number1 , number2 ) do
    div(number1 , number2)
  end

  def sub(number1 , number2 ) do
    number1 - number2
  end
end


# Calc.main()
