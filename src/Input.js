import React, {Component} from 'react';

class Input extends Component {
  constructor(props) {
    super(props);
    this.state = {course: "",
                  section: ""};
    this.handleInputChange = this.handleInputChange.bind(this);
    this.handleClick = this.handleClick.bind(this);
  }

  handleInputChange(event) {
    const target = event.target;
    const value = target.value;
    const name = target.name;

    this.setState({[name]: value});
  }

  handleClick(e){
    this.props.onChange(this.state.course, this.state.section);
  }

  render() {
    return (
      <form>
        <label>
          Course:
          <input
            name="course"
            type="text"
            value={this.state.course}
            onChange={this.handleInputChange} />
        </label>
        <br/>
        <label>
          Section:
          <input
            name="section"
            type="text"
            value={this.state.section}
            onChange={this.handleInputChange} />
        </label>
        <br/>
        <input type="submit" value="Submit" onClick={this.handleClick}/>
      </form>
    );
  }
}

export default Input;
