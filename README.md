# Bilingual practice — a sample web app implemented with pure functional programming

This small web app is a simple, quiz-like self-learning tool to practice foreign-languages phrases and words (here: German numbers, words and sentences).

It is implemented in Scotty, a Haskell microframework. For database, it uses a small self-made file-based storage library.

As for coding style, it intends to be extrmely DRY by using the tools where delcarative and functional programming languages can shine: algebraic datatypes, monad transformers, domain-specific embedded languages, arrows. Although the app is small, it tries to persent at least very embryonic stages of using very concise concepts and a point-free style stolen from and inspired by combinatory logic and category theory.
