/**
 * some interesting patterns 
*/

import java.util.Map;

static final int[][] gosper_glider_gun = {
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
  {0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
  {1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {1,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
};

static final int[][] pentadecathlon = {
  {1,1,1},
  {1,0,1},
  {1,1,1},
  {1,1,1},
  {1,1,1},
  {1,1,1},
  {1,0,1},
  {1,1,1},
};

static final int[][] lwss = {
  {0,0,1,1,0},
  {1,1,0,1,1},
  {1,1,1,1,0},
  {0,1,1,0,0},
};

static final int[][] die_hard = {
  {0,0,0,0,0,0,1,0},
  {1,1,0,0,0,0,0,0},
  {0,1,0,0,0,1,1,1},
};

static final int[][] acorn = {
  {0,1,0,0,0,0,0},
  {0,0,0,1,0,0,0},
  {1,1,0,0,1,1,1},
};


static final Map<Character, int[][]> PATTERN_MAP = new HashMap<Character, int[][]>();
static {
  PATTERN_MAP.put('a', acorn);
  PATTERN_MAP.put('g', gosper_glider_gun);
  PATTERN_MAP.put('p', pentadecathlon);
  PATTERN_MAP.put('l', lwss);
  PATTERN_MAP.put('d', die_hard);
}