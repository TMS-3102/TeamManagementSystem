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

  destroyTask = (e, taskId) => {
    e.preventDefault();
    
    fetch('tasks/' + taskId, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
      },
    }).then(() => this.getTasks());
  }
  
  completeTask = (e, task, completeStatus) => {
    e.preventDefault();
    
    task["completed"] = completeStatus;
    const data = { task }
    
    fetch('tasks/' + task.id + '/set_complete', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    }).then(this.getTasks());
  }

  removeUser = (e, taskId, userId) => {
    e.preventDefault();
    
    fetch('tasks/' + taskId + '/remove_user/' + userId, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
    }).then(() => this.getTasks());
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
                          <div className={task.task.completed ? 'card task-content done' : 'card task-content'}>
                            <div className={task.task.completed ? 'card-title done' : 'card-title'}>
                              <h3 className='left'>{task.task.title}</h3>
                              <h3 className='right'>Due: { task.task.deadline }</h3>
                            </div>
                            <div className="card-body">
                              <h5 className='priority'>Priority: { task.task.priority }</h5>
                              { task.task.description } <br/><br/>
                              
                              <div>
                                Assigned To:
                                { task.task.users.length === 0 &&
                                  <p>No One</p>
                                }
                                
                                { task.task.users.map((user) => {
                                    return (
                                      <div class='user'>
                                        <p>{user.name}</p>
                                        <a onClick={(e) => {this.removeUser(e, task.task.id, user.id)}}>Remove</a>
                                      </div>
                                    )
                                  }) 
                                }
                              </div>

                              <b>Post Date:</b> { new Date(task.task.created_at).toLocaleString() }
                              <div className='buttons'>
                                <div className='button modify-button'>
                                  <a href={"/teams/" + task.task.team_id + "/tasks/" + task.task.id + "/edit"}> Modify </a>
                                </div>
                                <div className='button destroy-button'>
                                  <a onClick={(e) => {this.destroyTask(e, task.task.id)}}> Delete </a>
                                </div>
                                <div className='button done-button'>
                                  { task.task.completed ?
                                    <a onClick={(e) => {this.completeTask(e, task.task, false)}}> Reactivate</a>
                                  :
                                    <a onClick={(e) => {this.completeTask(e, task.task, true)}}> Complete </a>

                                  }
                                </div>
                              </div>
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