import { QueryClient, QueryClientProvider } from 'react-query'

import './App.scss';

import React from 'react';

const queryClient = new QueryClient();

export const App = () => {
  return (
    <QueryClientProvider client={queryClient}>
    </QueryClientProvider>
  );
}