import React from 'react';
import ReactDOM from 'react-dom';
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';

class Tasks extends React.Component {
  state = {
    tasks: []
  }

  componentDidMount = () => {
    this.getTasks();
  }
  
  getTasks = () => {
    fetch('message_board.json')
      .then(messages => messages.json()) 
      .then(data => this.setState({tasks: data.message_board.messages}) );
  }

  handleDrop = (result) => {
    const { tasks } = this.state;
    const oldLoc = result.source.index;
    const newLoc = result.destination.index;
    console.log(oldLoc);
    console.log(newLoc);

    let rearrangedTasks = tasks;

    console.log(rearrangedTasks);

    for (const task in rearrangedTasks) {
      console.log(`${task}: ${rearrangedTasks[task]['message']['priority']}`);
      
      const loc = rearrangedTasks[task]['message']['priority']
      if(oldLoc == newLoc){
        console.log('no movement');
      } else if(oldLoc > newLoc && loc < oldLoc + 1) { // we dragged back
        if (loc == oldLoc) {
          console.log('we back to old');
          rearrangedTasks[task]['message']['priority'] = newLoc
        } else if(loc >= newLoc) {
          console.log('we here');
          rearrangedTasks[task]['message']['priority'] = loc + 1
        }
      } else { // we dragged forward
        console.log('we dragged forward');
        //This still needs to be done
      }
    }
    console.log(rearrangedTasks);
    const data = {
      tasks: rearrangedTasks
    }
    //create a bulk update method that changes the task position

    fetch('message_board/bulk_update', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    }).then(messages => messages.json()) 
      .then(data => this.setState({tasks: data.message_board.messages}) );
  }

  render() {
    const { tasks } = this.state;

    return (
      <div id='tasks-container'>
        <DragDropContext onDragEnd={this.handleDrop}>
          <Droppable droppableId='tasks'>
          {(provided) => (
            <ul className='tasks' {...provided.droppableProps} ref={provided.innerRef}>
              { tasks.map((task, index) => {
                  return (
                    <Draggable key={task.message.id} draggableId={''+task.message.id} index={index}>
                      {(provided) => (
                        <li ref={provided.innerRef} {...provided.draggableProps} {...provided.dragHandleProps}>
                          <div className='task-content'>
                            Name: {task.message.name} <br/>
                            Title: {task.message.title} <br/>
                            Content: {task.message.content} <br/>
                            index: {task.message.priority} <br/>
                          </div>
                        </li>
                      )}
                    </Draggable>
                  )
                })
              }
              {provided.placeholder}
            </ul>
          )}
          </Droppable>
        </DragDropContext>
      </div>
    )
  }
}


document.addEventListener("DOMContentLoaded", function(){
  const element = document.getElementById("tasks-mount-point");
  const data = JSON.parse(element.getAttribute('data'));
	ReactDOM.render( <Tasks tasks={data}/>, element );
});