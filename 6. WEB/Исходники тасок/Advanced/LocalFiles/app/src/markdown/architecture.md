# Markdown parser architecture

Prelude
-------

It needs to be stressed that making the parser modular while keeping it
relatively simple was a laborous undertaking. There has not been a standard
more hostile towards the people who dare attempt to implement it than
CommonMark. It should also be noted, that despite it being titled a
"Standard" in this document, it is less widely adopted than the Github
Flavored Markdown syntax. Github Flavored Markdown, however, is only but
a mere subset of this parser's model, albeit requiring a few extensions.

Current state (as of March 02, 2025)
------------------------------------

This parser processes text in what can be boiled down to three phases.

- Block/Line phase
- Overlay phase
- Inline phase

The first phase breaks down blocks, line by line, into block structures.
Blocks (preferably inherited from the Block class) can contain other blocks.
(i.e. QuoteBlock, ULBlock, OLBlock). Other blocks (known as leaf blocks)
may not contain anything else (except inline content, more on that later).

Blocks are designed to be parsed independently. This means that it *should*
be possible to tear out any standard block and make it not get parsed.
This, however, isn't thoroughly tested for.

Blocks as proper, real classes have a certain lifecycle to follow when
being constructed:

1. Open condition
    - A block needs to find its first marker on the current line to open
      (see `#begin?` method)
    - Once it's open, it's immediately initialized and fed the line it just
      read (but now as an object, not as a class) (see `#consume` method)
2. Marker/Line consumption
    - While it should be kept open, the block parser instance will
      keep reading inupt through `#consume` method, returning a pair
      of modified line (after consuming its tokens from it) and
      a boolean value indicating permission of lazy continuation
      (if it's a block like a QuoteBlock or ULBlock that can be lazily
      overflowed).
      Every line the parser needs to record needs to be pushed
      through the `#push` method.
3. Closure
    - If the current line no longer belongs to the current block
      (if the block should have been closed on the previous line),
      it simply needs to `return` a pair of `nil`, and a boolean value for
      permission of lazy continuation
    - If a block should be closed on the current line, it should capture it,
      keep track of the "closed" state, then `return` `nil` on the next call
      of `#consume`
    - Once a block is closed, it:
        1. Receives its content from the parser
        2. Parser receives the "close" method call
        3. (optional) Parser may have a callable method `#applyprops`. If
           it exists, it gets called with the current constructed block.
        4. (optional) All overlays assigned to this block's class are
           processed on the contents of this block (more on that in
           Overlay phase)
        5. (optional) Parser may return a different class, which
           the current block should be cast into (Overlays may change
           the class as well)
        6. (optional) If a block can respond to `#parse_inner` method, it
           will get called, allowing the block to parse its own contents.
    - After this point, the block is no longer touched until the document
      fully gets processed.
4. Inline processing
    - (Applies only to Paragraph and any child of LeafBlock)
      When the document gets fully processed, the contents of the current
      block are taken, assigned to an InlineRoot instance, and then parsed
      in Inline mode
5. Completion
    - The resulting document is then returned.

While there is a lot of functionality available in desgining blocks, it is
not necessary for the simplest of the block kinds available. The simplest
example of a block parser is likely the ThematicBreakParser class, which
implements the only 2 methods needed for a block parser to function.

While parsing text, a block may use additional info:

- In consume method: `lazy` hasharg, if the current line is being processed
  in lazy continuation mode (likely only ever matters for Paragraph); and
  `parent` - the parent block containing this block.


