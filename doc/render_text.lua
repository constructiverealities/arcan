-- render_text
-- @short: Convert a format string to a new video object.
-- @inargs: *dststore*, message, *vspacing*, *tspacing*, *tabs*
-- @outargs: vid, lineheights, width, height, ascent
-- @longdescr: Render a format string into a texture assigned to a new video
-- object. Return this object along with a table of individual line-heights.
-- The optional *dststore* can be used to update a previous result from
-- render_text, which cuts down on costs for dynamic allocation and recreating
-- or rebuilding related vid hierarchies, with the caveat that custom texture
-- coordinates from cropping and similar operations may still need to be
-- reapplied.
-- Render behavior varies with the type of *message*, which can be string
-- or a n-indexed table of strings. Anything else is a terminal state transition.
-- If *message* is a string, all contents will be treated as a format string
-- which is dangerous with user supplied content as escaping and dynamic string
-- construction is costly.
-- If *message* is a table of strings, strings at odd indices will be treated as
-- format strings and even indices are treated as raw UTF8.
-- Vspacing indicates the default padding between lines, and tspacing the
-- horizontal spacing between tabs. If *vspacing* is set to nil or 0, the added
-- padding will be taken from the font. Each formatting sequence is initiated
-- with a single backspace, followed with a command code (see table below).
-- Stateful commands (b, i, u) can be negated with a preluding exclamation point.
-- @tblent: t tab
-- @tblent: n newline
-- @tblent: r carriage-return
-- @tblent: u underline
-- @tblent: b bold
-- @tblent: i italic
-- @tblent: ffname,size_pt switch primary font, use f,size to use default
-- font which can be set with system_defaultfont or through the first used
-- successful render_text call. Set size to = 0 or add a sign specifier
-- (- or +) to specify relative to default font. Size is in points
-- assuming 28.8 ppcm density output as the internal font management cannot
-- currently take output display into account when rendering.
-- @tblent: #rrggbb switch font color
-- @tblent: pfname embed image
-- @tblent: Pfname,w,h embed image, scale to w*h
-- @tblent: evid,w,h embed vid, scale to w*h
-- @tblent: Evid,w,h,x1,y1,x2,y2 embed vid, scale subregion (x1,y1,x2,y2) to w*h
-- @group: image
-- @cfunction: buildstr
-- @note: Some format string states carry over between render_text calls, such
-- as the currently active font/size (to cut down on \ffontfile.ttf,num \#ffffff
-- style preludes.
-- @note: returned width and height does not necessarily match the values
-- returned by ref:text_dimensions
-- @note: Pfname,w,h function clamp to a built in limit (typically 256x256).
-- @exampleappl: tests/interactive/fonttest
-- @related: text_dimensions

