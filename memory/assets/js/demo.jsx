import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root) {
  ReactDOM.render(<Demo side={0}/>, root);
}

var shuffle = require('shuffle-array'),
alphabets = ['A','B','C','D','E','F','G','H','A','B','C','D','E','F','G','H'];

class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.initialState;
  }

  get initialState() {
    alphabets = shuffle(alphabets);
    var tiles = new Array(4);
    for (var i = 0; i<4 ;i++) {
      tiles[i] = new Array(4);
    }
    var count = 0;
    for(var i = 0; i < 4 ; i++) {
      for (var j = 0;j < 4; j++) {
        tiles [i][j] = { value:alphabets[count], opened: false, r:i, c:j, done: false };
        count +=1;
      }
    }
    return {
      tiles:tiles, firstPick: 0, secondPick: 0, correctState: false, finished: false, clicks: 0
    };
  }

  resetBuilder() {
    this.setState(this.initialState);
  }

  checkCorrectness(tile) {
    if(this.state.firstPick.value == this.state.secondPick.value) {
      this.state.correctState = true;
    }
    else {
      this.state.correctState = false;
    }
  }

  resetBoard(tile) {
    this.state.firstPick = 0;
    this.state.secondPick = 0;
    this.state.correctState = false;
  }

  flipback(tile) {
    this.state.tiles[this.state.firstPick.r][this.state.firstPick.c].opened = false;
    this.state.tiles[this.state.secondPick.r][this.state.secondPick.c].opened = false;
    this.setState({tiles:this.state.tiles});
    this.resetBoard(this);
  }

  markDone(tile) {
    this.state.tiles[this.state.firstPick.r][this.state.firstPick.c].done = true;
    this.state.tiles[this.state.secondPick.r][this.state.secondPick.c].done = true;
    this.setState({tiles:this.state.tiles});
    this.resetBoard(this);
  }

  revealTile(tile) {
    let row = tile.r;
    let col = tile.c;
    if(this.state.tiles[row][col].opened == false) {
      if(this.state.firstPick == 0) {
        this.state.tiles[row][col].opened = true;
        this.setState({tiles:this.state.tiles});
        this.state.clicks += 1;
        this.state.firstPick = tile;
      }
      else if(this.state.secondPick == 0) {
        this.state.tiles[row][col].opened = true;
        this.setState({tiles:this.state.tiles});
        this.state.clicks += 1;
        this.state.secondPick = tile;
        this.checkCorrectness(this);
        if(this.state.correctState) {
          setTimeout(()=>this.markDone(this), 500);
        }
        else {
          setTimeout(()=>this.flipback(this), 1000);
        }
      }
    }
  }

  render() {
    //go to each row and access each of the values from the object
    let tilelist = this.state.tiles.map((tilerow,rowindex)=>
      <tr key={rowindex}>
        {tilerow.map((tile,i)=>
          <td key={i} onClick={()=>this.revealTile(tile)}>
            <div className={tile.done? "tile done":"tile"}><p>{ tile.opened ? tile.value : '?'}</p></div>
          </td>)
        }
      </tr>);
      //var toggle = this.toggle.bind(this);
    return (
      <div>
        <table>
          <tbody>
            {tilelist}
          </tbody>
        </table>
        <ShowClicks root={this}/>
        <ShowReset reset={this.resetBuilder.bind(this)}/>
      </div>
    );
  }
}

function ShowClicks(props) {
  let root = props.root;
  console.log(root.state.clicks);
  return <h4>Number of Clicks: {root.state.clicks} </h4> ;
}

function ShowReset (props) {
  return  <Button onClick={ props.reset }> Reset </Button>
}

// References:
// https://reformatcode.com/code/javascript/using-map-function-for-two-dimensional-array---react
// https://stackoverflow.com/questions/45583925/using-map-function-for-two-dimensional-array-react
// https://stackoverflow.com/questions/32157286/rendering-react-components-from-array-of-objects
// https://css-tricks.com/forums/topic/trying-to-set-state-using-with-time-delay/
// https://codepen.io/_danko/pen/EypdyW
// https://www.youtube.com/watch?v=cZ90wJXtsQQ
// https://stackoverflow.com/questions/3943772/how-do-i-shuffle-the-characters-in-a-string-in-javascript
// https://www.npmjs.com/package/shuffle-array
// https://stackoverflow.com/questions/45200535/reset-initial-state-in-react-es6/45200755
