import Link from "next/link";

async function getEmployees() {
  const response = await fetch('http://localhost:3000/api/v1/employees', {
    next: {
      revalidate: 60
    }
  });

  if(!response.ok) {
    return response.text().then(message => { throw new Error(message) })
  }

  return response.json();
}

export default async function Employees() {
  const employees = await getEmployees();

  return (
    <>
      <h1>Employees</h1>
      <ul>
        {employees.data.map((employee: any) => (
          <li key={employee.id}>
            <Link href={`/employees/${employee.id}`}>{employee.attributes.name}</Link>
          </li>
        ))}
      </ul>
    </>
  )
}