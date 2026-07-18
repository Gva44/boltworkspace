export default function Home() {
  return (
    <main className="min-h-screen flex items-center justify-center bg-gray-100">
      <div className="bg-white shadow-lg rounded-xl p-10 w-full max-w-md text-center">
        <h1 className="text-3xl font-bold text-gray-900">
          Bolt Workspace
        </h1>

        <p className="mt-3 text-gray-600">
          Enterprise Project Management Platform
        </p>

        <button className="mt-8 w-full rounded-lg bg-blue-600 px-4 py-3 text-white font-semibold hover:bg-blue-700 transition">
          Continue with Google
        </button>

        <p className="mt-6 text-sm text-gray-400">
          Version 1.0
        </p>
      </div>
    </main>
  );
}