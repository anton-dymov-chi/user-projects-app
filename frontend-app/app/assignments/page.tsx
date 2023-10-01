async function getAssignments(assignmentableId: number, assignmentableType: string) {
  let queryString = `http://localhost:3000/api/v1/assignments?assignmentable_id=${assignmentableId}&&assignmentable_type=${assignmentableType}`
  const response = await fetch(queryString, {
    next: {
      revalidate: 60
    }
  });

  if(!response.ok) {
    return response.text().then(message => { throw new Error(message) })
  }

  return response.json();
}

type Props = {
  assignmentableId: number,
  assignmentableType: string
}

export default async function Assingments({assignmentableId, assignmentableType}: Props) {
  const assignments = await getAssignments(assignmentableId, assignmentableType);

  return(
    <>
      <h1>Assigments</h1>
      <br />
      <table>
        <thead>
          <th>Id</th>
          <th>Total</th>
          <th>Months</th>
          <th>RND Percentage</th>
        </thead>
        <tbody>
          {assignments.data.map((assignment: any) => (
            <tr key={assignment.id}>
              <td>{assignment.id}</td>
              <td>{assignment.attributes.total}</td>
              <td>{assignment.attributes.months}</td>
              <td>{assignment.attributes.rnd_percentage}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </>
  )
}
