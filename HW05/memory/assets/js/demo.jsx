import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root,channel) {
  ReactDOM.render(<Demo channel={channel} />, root);
}
var c = 0;
class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.state = { skel: [] , count: 0 };
    this.channel.join()
        .receive("ok", this.gotView.bind(this))
        .receive("error", resp => { console.log("Unable to join", resp) });
  }

  gotView(view) {
    console.log("New view", view);
    this.setState(view.game);
    // console.log("new game", view.game);
  }

  sendGuess(tile) {
    c = c + 1;
    let newgame = this.channel.push("play", { tile : tile })
        .receive("ok", this.gotView.bind(this));
    console.log(tile);
        if(c == 2){
          this.checkCorrectness();
          c = 0;
        }
  }
  checkCorrectness() {
    this.channel.push("check", { check : "game" })
        .receive("ok", this.gotView.bind(this));
  }

  resetBuilder(e){
    this.channel.push("reset", { reset : "game" })
        .receive("ok", this.gotView.bind(this));
  }

  render() {
    //go to each row and access each of the values from the object
    let tilelist = this.state.skel.map((tilerow,rowindex)=>
      <tr key={rowindex}>
        {tilerow.map((tile,i)=>
          <td key={i} onClick={()=>this.sendGuess(tile)}>
            <div className={tile.done? "tile done":"tile"}><p>{ tile.opened ? tile.value : "?"}</p></div>
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
        <ShowClicks state={this.state} />
        <Button onClick={()=>this.resetBuilder(this)}> Reset </Button>
      </div>
    );
  }
}

function ShowClicks(props) {
  let state = props.state;
  return <h4>Number of Clicks: {state.count} </h4> ;
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
