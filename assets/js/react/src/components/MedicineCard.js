import React, { useState, useEffect } from 'react';
import Paper from '@material-ui/core/Paper';

//importing devex react grid plugins
import { EditingState } from '@devexpress/dx-react-grid';
import {
    SearchState,
    IntegratedFiltering,
    PagingState,
    IntegratedPaging,
    SortingState,
    IntegratedSorting,
  } from '@devexpress/dx-react-grid';
import {
  Grid,
  Table,
  Toolbar,
  SearchPanel,
  TableHeaderRow,
  TableEditRow,
  TableEditColumn,
  PagingPanel,
} from '@devexpress/dx-react-grid-material-ui';

//To call API
import axios from 'axios'

//MaterialUI icon Button
import Button from '@material-ui/core/Button';
import ArrowDownward from '@material-ui/icons/ArrowDownward';
import ArrowUpward from '@material-ui/icons/ArrowUpward';
import Container from '@material-ui/core/Container'
//to get id of each row
const getRowId = row => row.id;

//For sorting the data
const SortingIcon = ({ direction }) => (
    direction === 'asc'
      ? <ArrowUpward style={{ fontSize: '18px' }} />
      : <ArrowDownward style={{ fontSize: '18px' }} />
  );
const SortLabel = ({ onSort, children, direction }) => (
    <Button
      size="small"
      variant="contained"
      onClick={onSort}
    >
      {children}
      {(direction && <SortingIcon direction={direction} />)}
    </Button>
  );

  //Main function
const MedicineCard=()=>{

    //Column 
    const [columns] = useState([
        { name: 'name', title: 'Medicine Name' },
        { name: 'dose', title: 'Doses'},
        { name: 'noOfMedicine', title: 'No of times'},
        { name: 'refill', title: 'Refill'},
        { name: 'comment', title: 'Doctors Comments'},
        { name: 'start', title: 'Start Date'},
        { name: 'end', title: 'End Date'},
      ]);

      //Rows
      const [rows, setRows] = useState([]);
      useEffect(()=>{
        getData();
      },[]
    );
        //to fetch data from api
      const getData = ()=>{
        axios.get('http://localhost:4000/api/medicines')
        .then(response =>{ 
          if(response.data!==[]){
           // console.log(response.data.data)
          setRows(response.data.data)
        }
        })
        .catch (error=> console.error(error));
      }
  
      // to set page size
      const [pageSizes] = useState([5, 10, 15, 0]);

      // To run CRUD operation where added,changed and deleted are paraters which passes the edited data
      const commitChanges = ({ added, changed, deleted }) => {
        let changedRows;
        if (added) {
          const startingAddedId = rows.length > 0 ? rows[rows.length - 1].id + 1 : 0;
          changedRows = [
            ...rows,
            ...added.map((row, index) => ({
              id: startingAddedId + index,
              ...row,
            })),
          ];
          added[0].refill=parseInt(added[0].refill,10);
          added[0].noOfMedicine=parseInt(added[0].noOfMedicine,10);
        //  console.log(added[0])
          axios.post('http://localhost:4000/api/medicines/',added[0])
        }
        if (changed) {
          changedRows = rows.map(row => (changed[row.id] ? { ...row, ...changed[row.id] } : row));
          let previousKey = Object.keys(changed);
          let key = parseInt(previousKey[0],10)
          console.log(changed);
          let updatedData = changed[key];
          axios.put('http://localhost:4000/api/medicines/'+key,updatedData)
        }
        if (deleted) {
          const deletedSet = new Set(deleted);
          changedRows = rows.filter(row => !deletedSet.has(row.id));
          
    console.log(changedRows)
          axios.delete('http://localhost:4000/api/medicines/'+deleted[0])
        }
        setRows(changedRows);
      };
    
      return (
        <Container fixed>
        <Paper>
      <h3>  <Grid
          rows={rows}
          columns={columns}
          getRowId={getRowId}
        >
        <SortingState
          defaultSorting={[{ columnName: 'name', direction: 'asc' }]}
        />
         <IntegratedSorting />
          <EditingState
            onCommitChanges={commitChanges}
          />
          <SearchState />
        <IntegratedFiltering />
        <PagingState
          defaultCurrentPage={0}
          defaultPageSize={5}
        />
        <IntegratedPaging />
          <Table />
           <TableHeaderRow
          showSortingControls
          sortLabelComponent={SortLabel}
        />
          <TableEditRow />
          <TableEditColumn
            showAddCommand
            showEditCommand
            showDeleteCommand
          />
           <Toolbar />
        <SearchPanel />
        <PagingPanel 
            pageSizes = {pageSizes}
        />
        </Grid></h3>
        </Paper>
        </Container>
      );
    };

export default MedicineCard