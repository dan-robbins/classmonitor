import React, {Component} from 'react';
import './App.css';
import Input from './Input';
import jQuery from 'jquery'

class App extends Component {
    constructor(props) {
        super(props);
        this.state = {course: "",
                      section: "",
                      seats: "",
                      open: "",
                      waitlist: "",
                      professor: "",
                      title: "",
                      time: "",
                      html: ""};
        this.makeRequest = this.makeRequest.bind(this);
        this.updateClass = this.updateClass.bind(this);
    }

    /*
    makeHttpObject() {
        try {return new XMLHttpRequest();}
        catch (error) {}
        //try {return new ActiveXObject("Msxml2.XMLHTTP");}
        //catch (error) {}
        //try {return new ActiveXObject("Microsoft.XMLHTTP");}
        //catch (error) {}
        throw new Error("Could not create HTTP request object.");
    }
    */

    makeRequest(course, section){
        //const url = "https://app.testudo.umd.edu/soc/search?courseId=" + course + "&sectionId=" + section + "&termId=201901&creditCompare=&credits=&courseLevelFilter=ALL&instructor=&_facetoface=on&_blended=on&_online=on&courseStartCompare=&courseStartHour=&courseStartMin=&courseStartAM=&courseEndHour=&courseEndMin=&courseEndAM=&teachingCenter=ALL&_classDay1=on&_classDay2=on&_classDay3=on&_classDay4=on&_classDay5=on"
        /*
        var request = this.makeHttpObject();
        request.open("POST", "https://app.testudo.umd.edu/soc/search?courseId=" + course + "&sectionId=" + section + "&termId=201901&creditCompare=&credits=&courseLevelFilter=ALL&instructor=&_facetoface=on&_blended=on&_online=on&courseStartCompare=&courseStartHour=&courseStartMin=&courseStartAM=&courseEndHour=&courseEndMin=&courseEndAM=&teachingCenter=ALL&_classDay1=on&_classDay2=on&_classDay3=on&_classDay4=on&_classDay5=on", true);
        request.send(null);
        request.onreadystatechange = function() {
            // eslint-disable-next-line
            if (request.readyState == 4)
            alert(request.responseText);
        };
        while(request.readyState === "loading"){}
        let parser = new DOMParser();
        let htmlDoc = parser.parseFromString(request, "text/xml");
        */
        var html;
        console.log('pre ajax')
        console.log(html)
        jQuery.ajax({
            type: "GET",
            url: 'file.php',
            dataType: 'json',
            data: {functionname: 'loadurl', arguments: [course, section]},

            success: function (obj, textstatus) {
                  if( !('error' in obj) ) {
                      html = obj.result;
                      console.log(html)
                      console.log('got result')
                      this.setState({html: obj.result})
                  }
                  else {
                      console.log(obj.error);
                  }
            }
        }).then(console.log('then')).then(console.log(html));
        console.log('post ajax')
        console.log(html)

        //const html = (await (await fetch(url)).text()); // html as text
        const htmlDoc = new DOMParser().parseFromString(html, 'text/html');
        let seats = htmlDoc.getElementsByClassName('total-seats-count')[0];
        let open = htmlDoc.getElementsByClassName('open-seats-count')[0];
        let waitlist = htmlDoc.getElementsByClassName('waitlist-count')[0];
        let professor = htmlDoc.getElementsByClassName('section-instructor')[0];
        let title = htmlDoc.getElementsByClassName('course-title')[0];
        let time = htmlDoc.getElementsByClassName('class-start-time')[0];
        this.setState({course: course,
                       section: section,
                       seats: seats,
                       open: open,
                       waitlist: waitlist,
                       professor: professor,
                       title: title,
                       time: time});
    }

    componentDidMount(){
        document.title = "UMD Class Monitor"
    }
    componentDidUpdate(){
        console.log('component did update')
        console.log(this.state.html)
    }
    updateClass(course, section){
        //this.setState({course: course,
        //               section: section});
        this.makeRequest(course, section);
    }
    render() {
        return (
            <div className = "App" >
                <Input onChange={this.updateClass}/>
                <p>
                    {this.state.class}<br/>
                    {this.state.section}<br/>
                    {this.state.seats}<br/>
                    {this.state.open}<br/>
                    {this.state.waitlist}<br/>
                    {this.state.professor}<br/>
                    {this.state.title}<br/>
                    {this.state.time}<br/>
                    {this.state.html}
                </p>
            </div>
        );
    }
}

export default App;
