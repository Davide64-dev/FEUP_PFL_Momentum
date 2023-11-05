:- use_module(library(random)).
:- use_module(library(lists)).
:-consult('io.pl').
:-consult('board/board.pl').
:-consult('game.pl').
:-consult('board/logic.pl').
:-consult('bot.pl').
:-consult('menu.pl').

play :-
    run_menu.
