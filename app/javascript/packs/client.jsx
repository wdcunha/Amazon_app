import React from 'react';
import ReactDOM from 'react-dom';
import App from '../components/App';
import {ready} from '../utilities';

ready(() => {
  // Instead of using a node that's already in the html
  // to hold the react app, we'll create a div
  // and place it in the document to hold the react app.
  const rootDiv = document.createElement('div');
  document.body.append(rootDiv);

  ReactDOM.render(
    <App />,
    rootDiv
  );
});
