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
    fetch('tasks.json')
      .then(tasks => tasks.json()) 
      .then(data => this.setState({tasks: data}) );
  }

  handleDrop = (result) => {
    const { tasks } = this.state;
    const oldLoc = result.source.index;
    const newLoc = result.destination.index;

    const rearrangedTasks = this.arraymove(tasks, oldLoc, newLoc);
    for (const task_index in rearrangedTasks) {
      rearrangedTasks[task_index]['task']['order'] = task_index
    }

    const data = {
      tasks: rearrangedTasks
    }
    
    fetch('tasks/bulk_update', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    }).then(tasks => tasks.json()) 
      .then(data => this.setState({tasks: data}) );
  }

  arraymove = (arr, fromIndex, toIndex) => {
    var element = arr[fromIndex];
    arr.splice(fromIndex, 1);
    arr.splice(toIndex, 0, element);
    return arr;
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
                    <Draggable key={task.task.id} draggableId={''+task.task.id} index={index}>
                      {(provided) => (
                        <li ref={provided.innerRef} {...provided.draggableProps} {...provided.dragHandleProps}>
                          <div className='card task-content'>
                            <div className='card-title'>
                              <b>{task.task.title}</b>
                            </div>
                            <div className='card-body'>
                              Description: {task.task.description} <br/>
                              Order: {task.task.order} <br/>
                              Priority: {task.task.priority} <br/>
                            </div>
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