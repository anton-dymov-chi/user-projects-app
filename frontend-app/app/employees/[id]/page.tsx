type Props = {
  params: {
    id: number;
  }
}

async function getEmployee(id: number) {
  const response = await fetch(`http://localhost:3000/api/v1/employees/${id}`, {
    next: {
      revalidate: 60
    }
  });

  if(!response.ok) {
    return response.text().then(message => { throw new Error(message) })
  }

  return response.json();
}

export default async function Post({ params: { id } }: Props) {
  const employee = await getEmployee(id);

  return(
    <h1>{employee.data.attributes.name}</h1>
  )
}