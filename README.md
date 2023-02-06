## Table view cell layout demo

This project shows a problem which happens when an `NSImageView` is added to an `NSTableCellView` laid out with AutoLayout. If the image is big enough, it expands the cell view beyond the column it's in (the cell view's width is larger than the table column's width and the width of its superview, `NSTableRowView`) and a part of the cell/image becomes hidden because it extends beyond the edge of the window.

The problem is that the `NSImageView` with a large image inside has a large `intrinsicContentSize`, but the internal constraint that the `NSTableView` uses to size its cells has a priority 500, so if the image is attached to the leading/trailing anchor of the cell, the image's preference to be larger overrides the cell's preferred size.

Is there any way to force a cell to be the same width as its column, no matter what's put inside it?

<a href="https://user-images.githubusercontent.com/28465/217004162-5ca9a274-db7a-4877-a193-f45ddebad6bd.png"><img width="800" src="https://user-images.githubusercontent.com/28465/217004162-5ca9a274-db7a-4877-a193-f45ddebad6bd.png"></a>
