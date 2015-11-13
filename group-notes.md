----OBJECTS----
Board {
  cell => {
      solved: true/false
      value: (1...9).to_a
      pos row: []
      pos col:[]
      pos box []
  }
}

----LOGIC----
MAKE BOARD
-9x9
-correct index
- no dashes

CHECK CELL IF EMPTY
return true if empty

CHECK ROW
  loop each row
      loop each cell
      if cell empty = true
      store index(row,column)
