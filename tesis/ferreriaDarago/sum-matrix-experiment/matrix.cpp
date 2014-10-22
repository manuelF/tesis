#include <mkl.h>
#include <stdio.h>
#include <string.h>

#include "matrix.h"

template<typename T>
Matrix<T>::Matrix(int _rows, int _cols) 
{
    rows = _rows; cols = _cols;
    data = (T *) mkl_malloc(bytes(), 64);
}

template<typename T>
Matrix<T>::~Matrix()
{
    mkl_free(data);
    data = NULL;
}

template<typename T>
Matrix<T>::Matrix(const Matrix<T> & other)
{
    rows = cols = 0; data = NULL;
    copy(other);
}

template<typename T>
Matrix<T> & Matrix<T>::operator=(const Matrix<T> & other)
{
    copy(other);
    return *this;
}

template<typename T>
int Matrix<T>::bytes() const {
    return rows * cols * sizeof(T);
}

template<typename T>
const T * Matrix<T>::asArray() const {
    return data;
}

template<typename T>
const T * Matrix<T>::row(int row) const {
    return &data[this->cols * row];
}

template<typename T>
void Matrix<T>::copy(const Matrix<T> & other)
{
    if(other.data == NULL) {
        mkl_free(data);
        data = NULL;
    } else {
        if(other.rows != rows || other.cols != cols) {
            mkl_free(data); 
            data = (T *) mkl_malloc(other.bytes(), 64);
        }
        memcpy(data, other.data, other.bytes());
    }

    rows = other.rows;
    cols = other.cols;
}

template<typename T>
void Matrix<T>::fill(T value) 
{
    for(int r = 0; r < rows; r++) {
        for(int c = 0; c < cols; c++) {
            ref(r,c) = value;
        }
    }
}

template class Matrix<float>;
